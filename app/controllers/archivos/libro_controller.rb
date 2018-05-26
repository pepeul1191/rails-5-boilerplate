class Archivos::LibroController < ApplicationController
	#protect_from_forgery except: :listar
	def subir
		rpta = nil
		status = 200
		begin
      file_name_array = params[:myFile].path.split('.')
      extension = file_name_array[file_name_array.length - 1].strip
			extension_id = Archivos::Extension.select(:id).where(:nombre => extension).first.id
			Archivos::Extension.select(:nombre, :mime).where(:id => params[:extension_id]).first.to_json
			nombre = params[:nombre]
			ruta = 'public/libros/'
			# mover el archivo
      FileUtils.mv(params[:myFile].path, ruta + nombre + '.' + extension)
			archivo = Archivos::Archivo.new(:nombre => (nombre + '.' + extension), :ruta => ruta, :extension_id => extension_id)
			archivo.save
      rpta = {
				:tipo_mensaje => 'success',
				:mensaje => [
					'Se ha cargado un nuevo libro',
					archivo.id,
          CONSTANTS[:STATIC_URL] + 'libros/' + params[:nombre] + '.' + extension
				]
			}.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en cargar el archivo',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end
end
