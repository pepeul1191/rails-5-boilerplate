class ApplicationController < ActionController::Base
  before_action :set_header
  before_action :validate_csrf_token
  skip_before_action :verify_authenticity_token

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

  private
  def validate_csrf_token
    if request.method == 'POST'
      #if request.params[:csrfretoken] != CONSTANTS[:CSRF] && CONSTANTS[:ambiente] != 'produccion'
        #render :plain => {:tipo_mensaje => 'error', :mensaje => ['CSRF token error', 'CSRF token error']}.to_json, status: 500
      #end
    end
  end

  private
  def set_header
    response.set_header('server', 'ruby, Ubuntu')
    #response.set_header('Access-Control-Allow-Origin', '*')
    #response.set_header('Access-Control-Allow-Methods', 'POST, PUT, DELETE, GET, OPTIONS')
    #response.set_header('Access-Control-Request-Method', '*')
    #response.set_header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization')
  end
end
