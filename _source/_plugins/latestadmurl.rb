require 'kramdown'
module Jekyll
  module Tags
    class LatestAdmUrl < Liquid::Tag
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
      end

      def render(context)
        context.registers[:site].config["latest_adm_url"]
      end
      
    end
  end
end

Liquid::Template.register_tag('latestadmurl', Jekyll::Tags::LatestAdmUrl)