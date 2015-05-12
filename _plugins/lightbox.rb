
# Example usage: {% lightbox 2012/abc.png, Title of Image, Alt Title %}
require 'kramdown'

module Jekyll
  class LightboxTag < Liquid::Tag
    def initialize(tag_name, text, token)
      super
      @text = text
    end


  def render(context)
    path, title, alt = @text.split('|').map(&:strip)
    output ="<div class=\"container\">
      <div class=\"row\">
        <div style=\"float:left;width:150px;height=140px; border-style:solid;border-color:#E5E4E2;border-radius:10px;padding:0px;position:relative;margin:0px;\">
         <p>
          <a  href=\"#{path}\" data-toggle=\"lightbox\">
             <img src=\"#{path}\" class=\"img-responsive img-rounded\">
          </a>
         </p>
        </div>
      </div>
    </div>"
    end
  end
end
 
Liquid::Template.register_tag('popup', Jekyll::LightboxTag)

#<div style=\"float:left;width:150px;height=140px; border-style:solid;border-color:#E5E4E2;border-radius:10px;padding-left:0px;padding-right:0px;position:relative;margin-left:0px;margin-right:0px;\">

#          <a  href=\"#{path}\" data-toggle=\"lightbox\" data-title=\"#{title}\">
