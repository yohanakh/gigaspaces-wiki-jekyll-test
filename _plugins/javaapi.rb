module Jekyll
  module Tags
    class JavaAPI < Liquid::Block
      
      def initialize(tag_name, text, tokens)
        super
        @text = text.strip
      end

      
      def render(context)
        output = "&nbsp;<a href=\"#{super}\"><img style=\"display:inherit;\" src=\"/attachment_files/logos/java_icon.jpeg\" alt=\"Java API\"></a>"
      end
    end
  end
end

Liquid::Template.register_tag('javaapi', Jekyll::Tags::JavaAPI)

