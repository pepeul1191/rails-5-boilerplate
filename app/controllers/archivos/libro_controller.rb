class Archivos::LibroController < ApplicationController
	#protect_from_forgery except: :listar
	def guardar_detalle
		rpta = nil
		status = 200
		data = JSON.parse(params[:data])
		begin
			if data['id'] == 'E'
				libro = Archivos::Libro.new(:nombre => data['nombre'], :paginas => data['paginas'], :anio => data['anio'])
				libro.save
				rpta = {
					:tipo_mensaje => 'success',
					:mensaje => [
						'Se ha registrado el detalle de un nuevo libro',
						libro.id,
					]
				}.to_json
			else
				archivo = Archivos::Libro.where(:id => data['id']).first
				archivo.nombre = data['nombre']
				archivo.paginas = data['paginas']
				archivo.anio = data['anio']
				archivo.save
				rpta = {
					:tipo_mensaje => 'success',
					:mensaje => [
						'Se ha editado el detalle de libro',
					]
				}.to_json
			end
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en registrar el detalle del libro',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end

	def guardar_archivo
		rpta = nil
		status = 200
		data = JSON.parse(params[:data])
		begin
			if data['id'] == 'E'
				status = 500
				rpta = {
					:tipo_mensaje => 'error',
					:mensaje => [
						'Debe primeo guardar el detalle del libro',
						libro.id,
					]
				}.to_json
			else
				archivo = Archivos::Libro.where(:id => data['id']).first
				archivo.archivo_id = data['archivo_id']
				archivo.save
				rpta = {
					:tipo_mensaje => 'success',
					:mensaje => [
						'Se ha agregado el documento al libro',
					]
				}.to_json
			end
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en anexar el archivo al libro',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end

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
