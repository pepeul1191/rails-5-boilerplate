module MenuHelper
  def self.menu_modulos
    rpta = nil
    begin
      r = HTTParty.get(
        CONSTANTS[:servicios][:accesos][:url] + 'modulo/menu/' + CONSTANTS[:sistema_id].to_s,
        headers:{
          CONSTANTS[:servicios][:accesos][:csrf_key] => CONSTANTS[:servicios][:accesos][:csrf_value],
          'Content-Type' => 'application/x-www-form-urlencoded',
          'charset' => 'utf-8'
        },
        query:{})
      if r.code == 500 || r.code == 404
        puts 'Error en listar módulos'
        rpta = '[]'
      else
        rpta = JSON.parse(r.body).to_json
      end
		rescue Exception => e
      puts e
      rpta = '[]'
		end
    rpta
  end

  def self.menu_items(nombre_modulo)
    rpta = nil
    begin
      r = HTTParty.get(
        CONSTANTS[:servicios][:accesos][:url] + 'item/menu',
        headers:{
          CONSTANTS[:servicios][:accesos][:csrf_key] => CONSTANTS[:servicios][:accesos][:csrf_value],
          'Content-Type' => 'application/x-www-form-urlencoded',
          'charset' => 'utf-8'
        },
        query:{
          :sistema_id => CONSTANTS[:sistema_id].to_s,
          :modulo => nombre_modulo,
        })
      if r.code == 500 || r.code == 404
        puts 'Error en listar subtítulos e items'
        rpta = '[]'
      else
        rpta = JSON.parse(r.body).to_json
      end
		rescue Exception => e
      puts e
      rpta = '[]'
		end
    rpta
  end
end
