require 'sequel'

Sequel.migration do
  up do
    Sequel.connect('sqlite://db/archivos.db')
    #Sequel.connect('mysql2://localhost/gestion?user=root&password=123')
		DB.transaction do
	  	file = File.new('db/data/ubicaciones_departamentos.txt', 'r')
			while (line = file.gets)
				line_array = line.split('::')
				id = line_array[0]
				nombre = line_array[1]
        nombre = line_array[2].strip
				#puts id + " - " + nombre
				DB[:extensiones].insert(id: id, nombre: nombre)
      end
		end
  end

	down do
		DB = Sequel.connect('sqlite://db/archivos.db')
    DB[:extensiones].delete
	end
end
