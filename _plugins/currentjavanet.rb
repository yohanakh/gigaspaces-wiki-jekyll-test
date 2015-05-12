require 'kramdown'
module Jekyll
  module Tags
    class CurrentJavaNet < Liquid::Tag
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
        @text = markup
      end

      def render(context)
      versionDir = context.environments.first["page"]["url"].split("/")[1]
      if !versionDir.nil?
        if versionDir.start_with?("xap")
          versionDir = versionDir.sub("xap","")
          versionDir = versionDir.sub("net","")
          versionDir = versionDir.sub("adm","")
          versionDir = versionDir.sub("sec","")
          versionDir = versionDir.sub("tut","")

          javaURL = "/xap" + versionDir +"/"  + @text
          netURL =  "/xap" + versionDir + "net/" + @text

          output = " ([Java version]("+ javaURL +") \\| [.Net version](" + netURL+")) "
        else
            latestJava = context.registers[:site].config["latest_java_url"]
            latestNet = context.registers[:site].config["latest_net_url"]

            output = " ([Java version]("+ latestJava +"/"+ @text +") \\| [.Net version](" + latestNet +"/"+ @text +")) "
        end
      else
        latestJava = context.registers[:site].config["latest_java_url"]
        latestNet = context.registers[:site].config["latest_net_url"]

        output = " ([Java version]("+ latestJava +"/"+ @text +") \\| [.Net version](" + latestNet +"/"+ @text +")) "
      end
     end

    end

  end

end

Liquid::Template.register_tag('currentjavanet', Jekyll::Tags::CurrentJavaNet)