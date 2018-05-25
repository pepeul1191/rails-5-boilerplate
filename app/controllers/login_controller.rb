class LoginController < ApplicationController
  def index
    @locals = {
      :title => 'Bienvenido',
      :hola => 'mundo',
      :css => [
        'bower_components/bootstrap/dist/css/bootstrap.min',
        'bower_components/font-awesome/css/font-awesome.min',
        'bower_components/swp-backbone/assets/css/constants',
        'bower_components/swp-backbone/assets/css/dashboard',
        'bower_components/swp-backbone/assets/css/table',
      ],
      :js => [
        'bower_components/jquery/dist/jquery.min',
        'bower_components/bootstrap/dist/js/bootstrap.min',
        'bower_components/underscore/underscore-min',
        'bower_components/backbone/backbone-min',
        'bower_components/backbone.marionette/lib/backbone.marionette.min',
        'bower_components/handlebars/handlebars.min',
        'bower_components/swp-backbone/layouts/application',
        'bower_components/swp-backbone/views/table',
        'bower_components/swp-backbone/views/modal',
      ],
    }
    render template: 'login/index', layout: 'blank'
  end
end
