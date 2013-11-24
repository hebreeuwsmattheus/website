# Assume the tools are located here
$: << File.realpath(File.join(File.dirname(__FILE__), '../tools/lib'))
# Make sure we can access the generator
$: << File.realpath(File.join(File.dirname(__FILE__), 'lib'))

task :build_chapters, :path do |t, args|
  require 'chapter_generator'
  
  source_path = File.realpath(args[:path])
  target_path = File.join(File.dirname(__FILE__), 'source/chapters')
  generator = ChapterGenerator.new source_path, target_path
  
  generator.remove_chapters
  generator.generate_chapters
end