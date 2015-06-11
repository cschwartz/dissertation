tex_subdir = 'tex'
junk_files = ['*.log', '*.bbl', '*.blg', '*.run.xml']
tex_root = 'dissertation'

graffle_files = Rake::FileList.new("tex/**/figures/*.graffle")

task default: :all

task :install_dependencies do
end

task :clean do
  Dir.chdir(tex_subdir) do
    sh 'latexmk -C'
    rm_rf `biber --cache`
    FileList.new(junk_files).each do |f|
    	rm f
    end
  end
end

task pdf: :convert_graffle_to_pdf do
  Dir.chdir(tex_subdir) do
  	sh "latexmk -interaction=nonstopmode -pdf #{ tex_root }.tex"
  end
end

task dev: [:clean, :convert_graffle_to_pdf] do
	Dir.chdir(tex_subdir) do
  	sh "latexmk -pvc -interaction=nonstopmode -pdf #{ tex_root }.tex"
  end
end

task :convert_graffle_to_pdf => graffle_files.ext('.pdf')

rule ".pdf" => ".graffle" do |t|
  convert_graffle_to_pdf t.source, t.name if is_osx?
end

task all: [:install_dependencies, :clean, :convert_graffle_to_pdf, :pdf]

def is_osx?
  RUBY_PLATFORM.include? 'darwin'
end

def convert_graffle_to_pdf(source, destination)
  omnigraffle =  "OmniGraffle Professional 5"

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
  tell application "#{omnigraffle}"
    open GraffleFile
    tell front document
      save in POSIX file PDFFileName
      if (alreadyOpen = false) then close
    end tell
  end tell
  --return PDFFileName
end run
on isOpen(aDoc)
  tell application "#{omnigraffle}"
    repeat with doc in documents
      if («class ppth» of doc as string) = aDoc then return true
    end repeat
    return false
  end tell
end isOpen
EOF
  sh 'osascript', '-e', conversion_script, source, destination
end