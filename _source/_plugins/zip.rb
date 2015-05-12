module Jekyll
  class ZipTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @url = text

    end

    def render(context)
     output = "<a href=\"#{@url}"
     output << "\"><i class=\"fa fa-file-archive-o fa-lg\"></i></a>"
    end
  end
end

Liquid::Template.register_tag('zip', Jekyll::ZipTag)
