require 'kramdown'

module Jekyll
  class XAPVersion < Liquid::Tag

    def initialize(tag_name, text, token)
      super
      @key = text
      @key.strip!
    end

      def render(context)

      @current_version = DocUtils.get_current_version(context)

      @str =  @current_version + "-" + @key

        context.registers[:site].config[@str]
      end
  end
end
 
Liquid::Template.register_tag('version', Jekyll::XAPVersion)
