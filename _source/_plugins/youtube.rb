
# Example usage: {% lightbox 2012/abc.png, Title of Image, Alt Title %}
require 'kramdown'

module Jekyll
  class VideoTag < Liquid::Tag
    def initialize(tag_name, text, token)
      super
      @text = text
    end



  def render(context)
    path, title, alt = @text.split('|').map(&:strip)
    output ="<div class=\"row\">
       <div style=\"float:left; width:200px;height=170px; padding-left:15px;padding-right:0px;position:relative;margin-left:0px;margin-right:0px;\">
        <p><a href=\"http://www.youtube.com/watch?v=#{path}\" data-width=\"853\" data-height=\"480\" data-toggle=\"lightbox\"> <img src=\"http://img.youtube.com/vi/#{path}/0.jpg\" class=\"img-responsive img-rounded\"> #{title} </a></p>
       </div>
    </div>"
    end
  end
end
 
Liquid::Template.register_tag('youtube', Jekyll::VideoTag)

