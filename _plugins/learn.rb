module Jekyll
  module Tags
    class Learn < Liquid::Block
      
      def initialize(tag_name, text, tokens)
        super
        @text = text.strip
      end

      
      def render(context)
#       output = "Learn more&nbsp;<a href=\"#{super}\"><img style=\"display:inherit;\" src=\"/attachment_files/navigation/learn.jpeg\" alt=\"Learn more\"></a>"
        output =                 "<a href=\"#{super}\"> <i class=\"fa fa-share \"></i>Learn more</a>"
      end
    end
  end
end

Liquid::Template.register_tag('learn', Jekyll::Tags::Learn)

#  output << "\"><i class=\"fa fa-university fa-lg\"></i>Learn more</a>"
# output = "Learn more&nbsp;<a href=\"#{super}\"><img style=\"display:inherit;\" src=\"/attachment_files/navigation/learn.jpeg\" alt=\"Learn more\"></a>"