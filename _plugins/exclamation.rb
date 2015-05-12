module Jekyll
  class ExclamationTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      "<i class='fa fa-exclamation-triangle' style='color:#CF9E53;'></i>"
    end
  end
end

Liquid::Template.register_tag('exclamation', Jekyll::ExclamationTag) 
