module Jekyll
  class CurrentAdmUrl < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @class_name = text.strip
    end

    def get_current_version(context)
      versionDir = context.environments.first["page"]["url"].split("/")[1]
      if !versionDir.nil?
        if versionDir.start_with?("xap")          
          versionDir = versionDir.sub("net","")
          versionDir = versionDir.sub("adm","")
          versionDir = versionDir.sub("sec","")
          versionDir = versionDir.sub("tut","")
          "/#{versionDir}adm"
        else 
          context.registers[:site].config["latest_adm_url"]
        end
      else
        context.registers[:site].config["latest_adm_url"]
      end
    end 

    def render(context)
      get_current_version(context)
    end
  end
end

Liquid::Template.register_tag('currentadmurl', Jekyll::CurrentAdmUrl)