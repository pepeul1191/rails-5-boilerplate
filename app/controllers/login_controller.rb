class LoginController < ApplicationController
  include LoginHelper
  before_action :session_false_view, only: [:index, ]
  def index
    @locals = {
      :title => 'Bienvenido',
      :hola => 'mundo',
      :css => LoginHelper::index_css,
      :js => LoginHelper::index_js,
    }
    render template: 'login/index', layout: 'blank'
  end

  def acceder
    continuar = true
    status = 200
    mensaje = ''
    begin
      r = HTTParty.post(
        CONSTANTS[:servicios][:accesos][:url] + 'sistema/usuario/validar',
        headers:{
          CONSTANTS[:servicios][:accesos][:csrf_key] => CONSTANTS[:servicios][:accesos][:csrf_value],
          'Content-Type' => 'application/x-www-form-urlencoded',
          'charset' => 'utf-8'
        },
        body:{
          :usuario => params[:usuario],
          :sistema_id => CONSTANTS[:sistema_id],
        })
      if r.code == 500 || r.code == 404
        continuar = false
        mensaje = 'Error Servicio Accesos : ' + r.body['mensaje'][0]
      end
      if continuar == true
        if r.body == '1'
          r = HTTParty.post(
            CONSTANTS[:servicios][:accesos][:url] + 'usuario/externo/validar',
            headers:{
              CONSTANTS[:servicios][:accesos][:csrf_key] => CONSTANTS[:servicios][:accesos][:csrf_value],
              'Content-Type' => 'application/x-www-form-urlencoded',
              'charset' => 'utf-8'
            },
            body:{
              :usuario => params[:usuario],
              :contrasenia => params[:contrasenia],
            })
          if r.code == 500 or r.code == 404
            continuar = false
            mensaje = 'Error Servicio Accesos : ' + r.body['mensaje'][0]
          else
            if r.body == '1'
              session[:estado] = 'autenticado'
              session[:usuario] = params[:usuario]
              session[:tiempo] = Time.now.strftime('%Y-%m-%d %H:%M:%S')
              redirect_to CONSTANTS[:BASE_URL]
            else
              continuar = false
              mensaje = 'Usuario y/o contraseña incorrectos'
            end
          end
        else
          continuar = false
          mensaje = 'Usuario no se encuentra registrado al sistema'
        end
      end
      if continuar == false
        @locals = {
          :title => 'Bienvenido',
          :hola => 'mundo',
          :css => LoginHelper::index_css,
          :js => LoginHelper::index_js,
          :mensaje => mensaje
        }
        render :template => 'login/index', :layout => 'blank', :status => 500
      end
		rescue Exception => e
      puts e
      @locals = {
        :title => 'Bienvenido',
        :hola => 'mundo',
        :css => LoginHelper::index_css,
        :js => LoginHelper::index_js,
        :mensaje => 'Error en login'
      }
      render :template => 'login/index', :layout => 'blank', :status => 500
		end
  end

  def ver
    rpta = 'usuario : ' + session[:usuario] + '</br>' +
      'estado : ' + session[:estado] + '</br>' +
      'tiempo : ' + session[:tiempo] + '</br>' +
      '<a style="margin-top:10px; display: block;width: 115px;height: 20px;background: #4E9CAF;padding: 10px;text-align: center;border-radius: 0px;color: white;font-weight: bold;" href="' + CONSTANTS[:BASE_URL] + 'login">Regresar</a>'
    render :inline => rpta
  end

  def cerrar
    reset_session
    redirect_to '/login'
  end
end
