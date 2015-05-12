module Jekyll
  module Tags
    class Git < Liquid::Tag
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
        @url = markup

      end

      def render(context)
        output = "<a href=\"#{@url}"
        output << "\"><i class=\"fa fa-github-alt fa-lg\"></i></a>"
      end


    end
  end
end

Liquid::Template.register_tag('git', Jekyll::Tags::Git)

