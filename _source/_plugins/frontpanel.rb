require 'kramdown'
module Jekyll
  module Tags
    class FrontPanel < Liquid::Block
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
      end

      def render(context)
      	add_panel(context, super)
      end

      def add_panel(context, content)
        style_string = ""
        style_string << "background-color:white;"
        style_string << "border-style:solid;"
        style_string << "border-color:#E5E4E2;"
        style_string << "border-radius:10px;"
#        style_string << "box-shadow: 10px 10px 5px #888888;"

      	output = "<div class='well' style='#{style_string}'>"

        output << Kramdown::Document.new(content).to_html
        output << "</div>"
      end
    end
  end
end

Liquid::Template.register_tag('fpanel', Jekyll::Tags::FrontPanel)