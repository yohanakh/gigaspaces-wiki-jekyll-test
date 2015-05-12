require 'kramdown'
module Jekyll
  module Tags
    class LatestJavaTutUrl < Liquid::Tag
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
      end

      def render(context)
        context.registers[:site].config["latest_java_tut_url"]
      end
      
    end
  end
end

Liquid::Template.register_tag('latestjavatuturl', Jekyll::Tags::LatestJavaTutUrl)