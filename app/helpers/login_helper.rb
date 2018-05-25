module LoginHelper
  def self.index_css
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        'bower_components/bootstrap/dist/css/bootstrap.min',
        'bower_components/font-awesome/css/font-awesome.min',
        'bower_components/swp-backbone/assets/css/constants',
        'bower_components/swp-backbone/assets/css/dashboard',
        'bower_components/swp-backbone/assets/css/table',
      ]
    else
      rpta = [
        'dist/login.min',
      ]
    end
    rpta
  end

  def self.index_js
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        'bower_components/jquery/dist/jquery.min',
        'bower_components/bootstrap/dist/js/bootstrap.min',
        'bower_components/underscore/underscore-min',
        'bower_components/backbone/backbone-min',
        'bower_components/backbone.marionette/lib/backbone.marionette.min',
        'bower_components/handlebars/handlebars.min',
        'bower_components/swp-backbone/layouts/application',
        'bower_components/swp-backbone/views/table',
        'bower_components/swp-backbone/views/modal',
      ]
    else
      rpta = [
        'dist/login.min',
      ]
    end
    rpta
  end
end
