module ApplicationHelper
  def ie_only_tag(&block)
    "<!--[if IE]>\n#{capture(&block)}<![endif]-->\n".html_safe
  end

  GOOGLE_FONT_PREFIX = "http://fonts.googleapis.com/css?family="

  def google_font_link_tag(family, types)
    capture do
      concat tag('link', {:rel => :stylesheet,
                          :type => 'text/css',
                          :href => "#{GOOGLE_FONT_PREFIX}#{family}:#{types.join(',')}"
                         },
                 false)
      concat "\n"

      # IE has to have each font in a different css file. Opera and Android
      # only apply the last style declared for a font, so we have to make a
      # conditional for IE only.
      concat(
        ie_only_tag do
          types.each do |type|
            concat tag('link', {:rel => :stylesheet,
                                :type => 'text/css',
                                :href => "#{GOOGLE_FONT_PREFIX}#{family}:#{type}"
                               },
                       false)
            concat "\n"
          end
        end
      )
    end
  end
end