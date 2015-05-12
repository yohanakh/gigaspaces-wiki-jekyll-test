module Jekyll
  class WordTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @url = text
    end

    def render(context)
         output = "<a href=\"#{@url}"
         output << "\"><i class=\"fa  fa-file-word-o fa-lg\"></i></a>"
    end
  end
end

Liquid::Template.register_tag('msword', Jekyll::WordTag)
