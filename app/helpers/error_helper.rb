module ErrorHelper
  def self.access_css
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        CONSTANTS[:BASE_URL] + 'bower_components/bootstrap/dist/css/bootstrap.min',
        CONSTANTS[:BASE_URL] + 'bower_components/font-awesome/css/font-awesome.min',
        CONSTANTS[:BASE_URL] + 'assets/css/constants',
        CONSTANTS[:BASE_URL] + 'assets/css/error',
        CONSTANTS[:BASE_URL] + 'assets/css/errorsh',
      ]
    else
      rpta = [
        CONSTANTS[:BASE_URL] + 'dist/error.min',
      ]
    end
    rpta
  end

  def self.access_js
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        CONSTANTS[:BASE_URL] + 'bower_components/jquery/dist/jquery.min',
        CONSTANTS[:BASE_URL] + 'bower_components/bootstrap/dist/js/bootstrap.min',
      ]
    else
      rpta = [
        CONSTANTS[:BASE_URL] + 'dist/error.min',
      ]
    end
    rpta
  end
end
