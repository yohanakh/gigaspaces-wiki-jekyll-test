require 'kramdown'
module Jekyll
  module Tags
    class Warning < Liquid::Block
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
        @icon  = true
        @title = ""
        unless markup.nil?
          markups = markup.split("|")

          title   = markups.select {|x| x =~ /title/}[0]
          icon    = markups.select {|x| x =~ /icon/}[0]

          @title  = title.sub("title=", "") if title
          @icon   = false if icon
        end
      end

      def render(context)
      	add_warning(context, super)
      end

      def add_warning(context, content)
        output = "<div class=\"bs-callout bs-callout-danger\">"
        unless @title.empty?
          output << "<strong>"
          output << Kramdown::Document.new(@title).to_html
          output << "</strong>"
        end
        output << Kramdown::Document.new(content).to_html
        output << "</div>"
      end
    end
  end
end

Liquid::Template.register_tag('warning', Jekyll::Tags::Warning)