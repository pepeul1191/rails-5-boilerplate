class LoginController < ApplicationController
  def index
    render template: 'login/index', layout: 'blank'
  end
end
