class Ubicaciones::ProvinciaController < ApplicationController
	#protect_from_forgery except: :listar
	def listar
		rpta = nil
		status = 200
		begin
      #Item.select(:id, :nombre, :url).where(:subtitulo_id => params['subtitulo_id']).all().to_a.to_json
			rpta = Ubicaciones::Provincia.select(:id, :nombre).where(:departamento_id => params[:departamento_id]).all().to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en guardar la tabla de provincias',
					e.message
				]
			}.to_json
		end
		render :plain => rpta, :status => status
	end
end
