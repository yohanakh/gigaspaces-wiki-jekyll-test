module Jekyll
  class QuestionTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      "<i class='fa fa-question-circle' style='color:#3B73AF;'></i>"
    end
  end
end

Liquid::Template.register_tag('question', Jekyll::QuestionTag) 
