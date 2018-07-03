module LoginHelper
  def self.index_css
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        CONSTANTS[:BASE_URL] + 'bower_components/bootstrap/dist/css/bootstrap.min',
        CONSTANTS[:BASE_URL] + 'bower_components/font-awesome/css/font-awesome.min',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/assets/css/constants',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/assets/css/login',
        CONSTANTS[:BASE_URL] + 'assets/css/login',
      ]
    else
      rpta = [
        CONSTANTS[:BASE_URL] + 'dist/login.min',
      ]
    end
    rpta
  end

  def self.index_js
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        CONSTANTS[:BASE_URL] + 'bower_components/jquery/dist/jquery.min',
        CONSTANTS[:BASE_URL] + 'bower_components/bootstrap/dist/js/bootstrap.min',
      ]
    else
      rpta = [
        CONSTANTS[:BASE_URL] + 'dist/login.min',
      ]
    end
    rpta
  end
end
