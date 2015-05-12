require 'kramdown'
module Jekyll
  module Tags
    class LatestJavaNet < Liquid::Tag
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
        @text = markup
      end

      def render(context)
      	add_refer(context, super)
      end

      def add_refer(context, content)

        javaURL = context.registers[:site].config["latest_java_url"]
        netURL = context.registers[:site].config["latest_net_url"]

        output = " ([Java version]("+ javaURL +"/" + @text + ") \\| [.Net version](" + netURL +"/" + @text + ")) "
      end
    end
  end
end

Liquid::Template.register_tag('latestjavanet', Jekyll::Tags::LatestJavaNet)