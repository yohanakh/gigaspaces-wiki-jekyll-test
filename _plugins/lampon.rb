module Jekyll
  class LamponTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      "<span class='fa-stack'><i class='fa fa-sun-o fa-stack-2x'></i><i class='fa fa-lightbulb-o fa-stack-1x'></i></span>"
    end
  end
end

Liquid::Template.register_tag('lampon', Jekyll::LamponTag) 
