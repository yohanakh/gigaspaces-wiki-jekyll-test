module Jekyll
  module Tags
    class NetLearn < Liquid::Block
      
      def initialize(tag_name, text, tokens)
        super
        @text = text.strip
      end

      
      def render(context)
        output = ".Net&nbsp;<a href=\"#{super}\"><img style=\"display:inherit;\" src=\"/attachment_files/navigation/learn.jpeg\" alt=\"Learn more\"></a>"
      end
    end
  end
end

Liquid::Template.register_tag('netlearn', Jekyll::Tags::NetLearn)

