module Jekyll
  class InfosignTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      "<i class='fa fa-info-circle' style='color:#3B73AF;'></i>"
    end
  end
end

Liquid::Template.register_tag('infosign', Jekyll::InfosignTag) 
