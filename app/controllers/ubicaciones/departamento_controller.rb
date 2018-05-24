class Ubicaciones::DepartamentoController < ApplicationController
	#protect_from_forgery except: :listar
	def listar
		rpta = nil
		status = 200
		begin
			rpta = Ubicaciones::Departamento.all().to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en guardar la tabla de departamentos',
					e.message
				]
			}.to_json
		end
		render :plain => rpta, :status => status
	end
end
