class ApplicationController < ActionController::Base
  before_action :set_header
  skip_before_action :verify_authenticity_token
  """
  def not_found
    case request.method
    when 'GET'
      extensiones_archivos = ['css', 'js', 'png', 'img', ]
      request_array = request.original_url.split('.')
      extension = request_array[request_array.length - 1]
      if !extensiones_archivos.include? extension
        redirect_to CONSTANTS[:BASE_URL] + 'error/access/404'
      end
    when 'POST'
      render :plain => {
        :tipo_mensaje => 'error',
        :mensaje => [
          '404: Recurso no encontrado',
          ]
        }.to_json, status: 500
    end
  end
  """
  private
  def set_header
    response.set_header('server', 'ruby, Ubuntu')
    #response.set_header('Access-Control-Allow-Origin', '*')
    #response.set_header('Access-Control-Allow-Methods', 'POST, PUT, DELETE, GET, OPTIONS')
    #response.set_header('Access-Control-Request-Method', '*')
    #response.set_header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization')
  end

  private
  def validate_csrf
    if CONSTANTS[:ambiente_csrf] == 'activo'
      if request.headers[CONSTANTS[:CSRF][:key]] != CONSTANTS[:CSRF][:secret]
        rpta = {
  				:tipo_mensaje => 'error',
  				:mensaje => [
  					'No se puede acceder al recurso',
  					'CSRF Token error'
  				]
  			}.to_json
  			status = 500
        render :plain => rpta, :status => status
      end
    end
  end

  private
  def session_true_view
    if CONSTANTS[:ambiente_session] == 'activo'
      if session[:estado] != 'autenticado'
        redirect_to CONSTANTS[:BASE_URL] + 'error/access/5051'
      end
    end
  end

  private
  def session_false_view
    if CONSTANTS[:ambiente_session] == 'activo'
      if session[:estado] == 'autenticado'
        redirect_to CONSTANTS[:BASE_URL]
      end
    end
  end

  private
  def session_true_rest
    if CONSTANTS[:ambiente_session] == 'activo'
      if session[:estado] != 'autenticado'
        rpta = {
  				:tipo_mensaje => 'error',
  				:mensaje => [
  					'No se puede acceder al recurso',
  					'Necesita estar logueado'
  				]
  			}.to_json
  			status = 500
        render :plain => rpta, :status => status
      end
    end
  end
end
