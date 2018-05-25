module ErrorHelper
  def self.access_css
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        'bower_components/bootstrap/dist/css/bootstrap.min',
        'bower_components/font-awesome/css/font-awesome.min',
        'assets/css/constants',
        'assets/css/error',
      ]
    else
      rpta = [
        'dist/error.min',
      ]
    end
    rpta
  end

  def self.access_js
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        'bower_components/jquery/dist/jquery.min',
        'bower_components/bootstrap/dist/js/bootstrap.min',
      ]
    else
      rpta = [
        'dist/error.min',
      ]
    end
    rpta
  end
end
