module Jekyll
  class ExternUrlTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      "<i class='fa fa-external-link'></i>"
    end
  end
end

Liquid::Template.register_tag('externalurl', Jekyll::ExternUrlTag)
