module Jekyll
  class DownloadTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @url = text
    end

    def render(context)
         output = "<a href=\"#{@url}"
         output << "\"><i class=\"fa fa-download fa-lg\"></i></a>"
    end
  end
end

Liquid::Template.register_tag('download', Jekyll::DownloadTag)
