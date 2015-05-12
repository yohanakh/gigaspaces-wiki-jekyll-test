require 'kramdown'
module Jekyll
  module Tags
    class LatestSecUrl < Liquid::Tag
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
      end

      def render(context)
        context.registers[:site].config["latest_sec_url"]
      end
      
    end
  end
end

Liquid::Template.register_tag('latestsecurl', Jekyll::Tags::LatestSecUrl)