module ApplicationHelper
  def load_css
    rpta = ''
    if defined? @locals[:css]
      @locals[:css].each do |n|
        temp = '<link href="' + n + '.css" rel="stylesheet"/>'
        rpta = rpta + temp
      end
    end
    rpta.html_safe
  end

  def load_js
    rpta = ''
    if defined? @locals[:js]
      @locals[:js].each do |n|
        temp = '<script src="' + n + '.js" type="text/javascript"></script>'
        rpta = rpta + temp
      end
    end
    rpta.html_safe
  end
end
