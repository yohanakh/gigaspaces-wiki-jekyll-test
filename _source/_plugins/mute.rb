require 'kramdown'

module Jekyll
  module Tags
    class MuteTag < Liquid::Block
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
      end

      def render(context)
      	add_info(context, super)
      end


      def add_info(context, content)
       output = "<p class=\"text-muted\"><big><i>"
       output << content
       output << "</i></big></p>"
      end
    end
  end
end

Liquid::Template.register_tag('mute', Jekyll::Tags::MuteTag)