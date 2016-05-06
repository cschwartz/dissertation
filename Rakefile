require 'yaml'
require 'colorize'
require 'nokogiri'
require 'csv'

config = YAML.load_file('config.yml')

tex_subdir = 'tex'
figures_subdir = 'figures'
tex_root = 'dissertation'

JUNK_FILES = FileList.new(['tex/**/*.log', 'tex/**/*.bbl', 'tex/**/*.blg', 'tex/**/*.run.xml'])

GRAFFLE_FILES = Rake::FileList.new('figures/**/*.graffle')
PLOT_FILES = Rake::FileList.new('figures/**/*.R').exclude('figures/**/plot_settings.R').exclude { |f| 
  File.basename(f).start_with? '_'
}.exclude { |f|
  File.basename(f).end_with?('_deutsch.R')
}.exclude('figures/plot_vortrag_de.R')

p PLOT_FILES
GENERATED_FIGURE_FILES = Rake::FileList.new('tex/**/figures/*.pdf').exclude('tex/figures/*.pdf')

OMNIGRAFFLE =  "OmniGraffle Professional 5"

FIGURE_PROCESSING_RULES = {
  '.graffle' => -> (source, destination) {  convert_graffle_to_pdf(source, destination) },
  '.R' => ->(source, destination) { convert_r_to_pdf(source, destination) }
}

ALL_FIGURE_FILES = GRAFFLE_FILES + PLOT_FILES

FIGURE_PATHMAP = "%{^figures,tex}d/figures/%n.pdf"

task default: :all

task :install_dependencies do
end

task :clean do
  rm_rf `biber --cache`

  Dir.chdir(tex_subdir) do
    sh 'latexmk -C'
  end

  rm JUNK_FILES

  rm GENERATED_FIGURE_FILES
end

task pdf: [:process_graphics] do
  Dir.chdir(tex_subdir) do
    sh "latexmk -interaction=nonstopmode -pdf #{ tex_root }.tex"
  end
end

task :references_figure do
  bcf_file_path = File.join tex_subdir, 'dissertation.aux'
  citekeys_file = File.join figures_subdir, 'citekeys.csv'

  File.open bcf_file_path do |bcf_file|
    CSV.open citekeys_file, 'wb', col_sep: ';' do |csv|
      citation = /\\abx@aux@number\{\d+\}\{([A-z0-9]+)\}\{0\}\{none\}\{(\d+)\}/
      csv << ['reference', 'key']
      bcf_file.each_line do |line|
        next unless line =~ citation
        csv << [$2, $1]
      end
    end
  end
end

task dev: [:process_graphics] do
	Dir.chdir(tex_subdir) do
    sh "latexmk -pvc -interaction=nonstopmode -pdf #{ tex_root }.tex"
  end
end

task :process_graphics => ALL_FIGURE_FILES.pathmap(FIGURE_PATHMAP)

task all: [:process_graphics, :pdf]

task :check_for_typos do
  config["typos"].each do |typo_candidate|
    puts "Checking for '#{typo_candidate}'"
    Dir['**/*.tex'].each do |f|
      ack_result = `ack --output '$.: $_' \"#{typo_candidate}\" #{f}`
      unless ack_result.empty?
        puts f
        puts ack_result.gsub(typo_candidate, typo_candidate.red)
      end
    end
  end
end

task :check_fonts => :pdf do
  puts "checking fonts..."
  Dir['tex/**/figures/*.pdf'].each do |f|
    out = `pdffonts #{ f }`
    if out.include?('TrueType') || out.include?('MSBM10')
      puts f
      puts source_path(f)
      puts out
      puts "======"
    end
  end
  puts "done"
end

rule '.pdf' => -> (f) {source_path(f)} do |t|
  ensure_destination_path_exists(t.name)
  extension = File.extname(t.source)
  FIGURE_PROCESSING_RULES[extension].call(t.source, t.name)
end

def source_path(pdf_file)
  base_path = pdf_file.pathmap('%{^tex,figures}d%').gsub(/figures$/,'')
  source_file_name = pdf_file.pathmap("%n")
  ALL_FIGURE_FILES.detect { |f| f.ext == File.join(base_path, source_file_name) }
end

def ensure_destination_path_exists(destination)
  destination_path = destination.pathmap("%d")
  mkdir_p File.dirname(destination_path)
end

def is_osx?
  RUBY_PLATFORM.include? 'darwin'
end

def convert_r_to_pdf(source, destination)
  mkdir_p File.dirname(destination)
  absolute_destination = File.absolute_path(destination)
  sh %Q|Rscript --quiet -e "source('figures/plot_settings.R')" -e "source('#{ source }', chdir=T)" #{ absolute_destination }|
end

def convert_graffle_to_pdf(source, destination)
  conversion_script = <<EOF
on run argv
  -- Current working directory
  set PWD to do shell script "pwd" -- the env var is system attribute "PWD" but it breaks with make -C subdir
  -- Relative paths
  set FileName to PWD & "/" & item 1 of argv
  set PDFFileName to PWD & "/" & item 2 of argv

  set alreadyOpen to isOpen(FileName)

  tell application "Finder"
    set GraffleFile to POSIX file FileName as alias
  end tell
  tell application "#{OMNIGRAFFLE}"
    open GraffleFile
    set canvas of front window to canvas 1 of front document
    tell front document
      save in POSIX file PDFFileName
      close
    end tell
  end tell
  --return PDFFileName
end run
on isOpen(aDoc)
  tell application "#{OMNIGRAFFLE}"
    repeat with doc in documents
      if («class ppth» of doc as string) = aDoc then return true
    end repeat
    return false
  end tell
end isOpen
EOF
  sh 'osascript', '-e', conversion_script, source, destination
end
