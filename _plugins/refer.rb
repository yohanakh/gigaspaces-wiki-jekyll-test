require 'kramdown'
module Jekyll
  module Tags
    class ReferTag < Liquid::Block
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
      end

      def render(context)
      	add_info(context, super)
      end


      def add_info(context, content)

      output = "<div class=\"col-sm-12\">
                 <div class=\"well well-sm\">
                 <i class=\"fa fa-hand-o-right fa-lg pull-left\"></i>"

       output << Kramdown::Document.new(content).to_html
       output << "</div></div>"
      end
    end
  end
end

Liquid::Template.register_tag('refer', Jekyll::Tags::ReferTag)