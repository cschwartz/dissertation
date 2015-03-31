tex_subdir = 'tex'
junk_files = ['*.log', '*.bbl', '*.blg', '*.run.xml']
tex_root = 'dissertation'

task default: :all

task :clean do
  Dir.chdir(tex_subdir) do
    sh 'latexmk -C'
    FileList.new(junk_files).each do |f|
    	rm f
    end
  end
end

task :pdf do
  Dir.chdir(tex_subdir) do
  	sh "latexmk -pdf #{ tex_root }.tex"
  end
end

task dev: [:clean] do
	Dir.chdir(tex_subdir) do
  	sh "latexmk -pvc -pdf #{ tex_root }.tex"
  end
end

task all: [:clean, :pdf]