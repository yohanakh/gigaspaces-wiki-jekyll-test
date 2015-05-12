module Jekyll
  class PlusTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      "<i class='fa fa-plus-circle' style='color:#14892C;'></i>"
    end
  end
end

Liquid::Template.register_tag('plus', Jekyll::PlusTag) 
