class Archivos::ExtensionController < ApplicationController
	#protect_from_forgery except: :listar
	def listar
		rpta = nil
		status = 200
		begin
			rpta = Archivos::Extension.all().to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar las extensiones',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end

	def count
		rpta = nil
		status = 200
		begin
			rpta = Archivos::Extension.all().count
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en contar las extensiones',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end

	def guardar
		rpta = nil
		status = 200
		data = JSON.parse(params[:data])
		nuevos = data['nuevos']
		editados = data['editados']
		eliminados = data['eliminados']
		rpta = []
		array_nuevos = []
		error = false
		execption = nil
		DB_ARCHIVOS.transaction do
			begin
				if nuevos.length != 0
					nuevos.each do |nuevo|
						n = Archivos::Extension.new(:nombre => nuevo['nombre'], :mime => nuevo['mime'],)
						n.save
						t = {:temporal => nuevo['id'], :nuevo_id => n.id}
						array_nuevos.push(t)
					end
				end
				if editados.length != 0
					editados.each do |editado|
						e = Archivos::Extension.where(:id => editado['id']).first
						e.nombre = editado['nombre']
            e.mime = editado['mime']
						e.save
					end
				end
				if eliminados.length != 0
					eliminados.each do |eliminado|
						Archivos::Extension.where(:id => eliminado).delete
					end
				end
			rescue Exception => e
				Sequel::Rollback
				error = true
				execption = e
			end
		end
		if error == false
			rpta = {
				:tipo_mensaje => 'success',
				:mensaje => [
					'Se ha registrado los cambios en las extensiones',
					array_nuevos
					]
				}.to_json
		else
			status = 500
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en guardar la tabla de extensiones',
					execption.message]
				}.to_json
		end
		render :plain => rpta, :status => status
	end

  def nombre_mime
    rpta = nil
    status = 200
    begin
      rpta = Archivos::Extension.select(:nombre, :mime).where(:id => params[:extension_id]).first.to_json
    rescue Exception => e
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error el nombre y mime de la extensión',
          e.message
        ]
      }.to_json
      status = 500
    end
    render :plain => rpta, :status => status
  end
end
