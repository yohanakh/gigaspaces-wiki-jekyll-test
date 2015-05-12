module Jekyll
  module Tags
    class NetAPI < Liquid::Block
      
      def initialize(tag_name, text, tokens)
        super
        @text = text.strip
      end

      
      def render(context)
        output = "&nbsp;<a href=\"#{super}\"><img style=\"display:inherit;\" src=\"/attachment_files/logos/dotnet.jpeg\" alt=\".NET API\"></a>"
      end
    end
  end
end

Liquid::Template.register_tag('netapi', Jekyll::Tags::NetAPI)

