module Jekyll
  class LampoffTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      "<i class='fa fa-lightbulb-o'></i>"
    end
  end
end

Liquid::Template.register_tag('lampoff', Jekyll::LampoffTag) 
