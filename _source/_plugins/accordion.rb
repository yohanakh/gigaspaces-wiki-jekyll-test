require 'securerandom'

module Jekyll
  module Tags

    class Accordion < Liquid::Block
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
        if markup.empty?
          @div_id = "generic"
        else
          @div_id  = markup.strip.sub("id=", "")
        end
      end

      def render(context)
      	add_accordion(context, super)
      end

      def add_accordion(context, content)
        output = "<div class='panel-group' id='#{@div_id}'>"
        output << Kramdown::Document.new(content).to_html
        output << "</div>"
      end
    end

    class Accord < Liquid::Block
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super


         markups = markup.split("|")

         title   = markups.select {|x| x =~ /title/}[0]
         parent  = markups.select {|x| x =~ /parent/}[0]

         @title  = title.sub("title=", "") if title
         @parent = parent.strip.sub("parent=", "") if parent
      end

      def render(context)
      	add_accord(context, super)
      end



      def add_accord(context, content)

        random_string = SecureRandom.hex

        output =   "<div class='panel panel-default'>
                     <div class='panel-heading'>
                       <h4 class='panel-title'>
                         <a data-toggle='collapse' data-parent='##{@parent}' href='##{random_string}'>
                          #{@title}
                         </a>
                       </h4>
                     </div>
                     <div id='#{random_string}' class='panel-collapse collapse'>
                       <div class='panel-body'>"
        output << Kramdown::Document.new(content).to_html
        output << "</div></div></div>"
      end
    end
  end
end

Liquid::Template.register_tag('accordion', Jekyll::Tags::Accordion)
Liquid::Template.register_tag('accord', Jekyll::Tags::Accord)


