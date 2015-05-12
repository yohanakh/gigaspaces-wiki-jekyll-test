require 'kramdown'
module Jekyll
  module Tags
    class LatestNetTutUrl < Liquid::Tag
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
      end

      def render(context)
        context.registers[:site].config["latest_net_tut_url"]
      end
      
    end
  end
end

Liquid::Template.register_tag('latestnettuturl', Jekyll::Tags::LatestNetTutUrl)