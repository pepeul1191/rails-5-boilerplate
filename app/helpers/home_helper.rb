module HomeHelper
  def self.index_css
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        CONSTANTS[:BASE_URL] + 'bower_components/bootstrap/dist/css/bootstrap.min',
        CONSTANTS[:BASE_URL] + 'bower_components/font-awesome/css/font-awesome.min',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/assets/css/constants',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/assets/css/dashboard',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/assets/css/table',
        CONSTANTS[:BASE_URL] + 'assets/css/constants',
        CONSTANTS[:BASE_URL] + 'assets/css/styles',
      ]
    else
      rpta = [
        CONSTANTS[:BASE_URL] + 'dist/home.min',
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
        CONSTANTS[:BASE_URL] + 'bower_components/underscore/underscore-min',
        CONSTANTS[:BASE_URL] + 'bower_components/backbone/backbone-min',
        CONSTANTS[:BASE_URL] + 'bower_components/backbone.marionette/lib/backbone.marionette.min',
        CONSTANTS[:BASE_URL] + 'bower_components/handlebars/handlebars.min',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/layouts/application',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/views/table',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/views/modal',
      ]
    else
      rpta = [
        CONSTANTS[:BASE_URL] + 'dist/home.min',
      ]
    end
    rpta
  end
end
