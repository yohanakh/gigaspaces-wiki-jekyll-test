module Jekyll
  class FolderOpenTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      "<i class='fa fa-folder-open fa-lg' style='color:#FACC2E;'></i>"
    end
  end
end

Liquid::Template.register_tag('folderopen', Jekyll::FolderOpenTag)
