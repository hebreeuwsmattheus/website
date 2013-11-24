require 'mattheus'
require 'erb'
require 'action_view/helpers/text_helper'

class ChapterGenerator
  def initialize(source_path, target_path)
    @parser = Mattheus::Parser.new source_path
    @target_path = target_path
  end
  
  def generate_chapters
    unless File.directory? @target_path
      Dir.mkdir @target_path
    end
    
    template = ERB.new(File.read(File.join(File.dirname(__FILE__), '../templates/chapter.erb')))
    @parser.he.each do |chapter_id, chapter|
      chapter_path = File.join(@target_path, "#{chapter_id}.html.erb")
      chapter_namespace = Chapter.new(@parser, chapter_id)
      
      template.result(chapter_namespace.get_binding)
      File.open(chapter_path, 'w') do |file| 
        file.write(template.result(chapter_namespace.get_binding))
      end
    end
  end
  
  def remove_chapters
    if File.directory? @target_path
      Dir["#{@target_path}/*.html.erb"].each do |path|
        File.delete path
      end
    end
  end
  
  class Chapter
    def initialize(parser, chapter_id)
      @parser, @chapter_id = parser, chapter_id
    end
    
    %w(he nl margin).each do |meth|
      define_method(meth) { @parser.send(meth)[@chapter_id] }
    end
    
    def get_binding
      binding
    end
  end
end