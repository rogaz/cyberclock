# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.destroy_all

ActiveRecord::Base.connection.execute 'ALTER SEQUENCE users_id_seq RESTART WITH 1;'

user = User.new(login: 'admin', name: 'Administrador', email: 'admin@correo.com', password: '123123', password_confirmation: '123123')
user.add_role 'admin'
user.save

if user.valid?
  puts "\n\t* Usuario administrador creado.\n\n"
else
  puts "\nNo se pudo crear el usuario administrador por los siguientes errores:"
  user.errors.full_messages.each do |msg|
    puts "\t* #{msg}"
  end
  puts "\n"
end
