class Ubicaciones::DepartamentoController < ApplicationController
	#protect_from_forgery except: :listar
	def listar
		render :plain => Ubicaciones::Departamento.all().to_a.to_json
	end
end
