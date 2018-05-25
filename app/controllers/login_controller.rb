class LoginController < ApplicationController
  include LoginHelper
  def index
    @locals = {
      :title => 'Bienvenido',
      :hola => 'mundo',
      :css => LoginHelper::index_css,
      :js => LoginHelper::index_js,
    }
    render template: 'login/index', layout: 'blank'
  end
end
