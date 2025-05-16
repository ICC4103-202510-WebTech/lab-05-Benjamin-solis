puts "Limpiando la base de datos..."
Message.destroy_all
Chat.destroy_all
User.destroy_all

users = [
  User.create!(email: "claudio.bravo@ejemplo.com", first_name: "Claudio", last_name: "Bravo"
  ),
  User.create!(email: "alexis.sanchez@ejemplo.com", first_name: "Alexis", last_name: "Sánchez"
  ),
  User.create!(email: "arturo.vidal@ejemplo.com", first_name: "Arturo", last_name: "Vidal"
  ),
  User.create!(email: "gary.medel@ejemplo.com", first_name: "Gary", last_name: "Medel"
  ),
  User.create!(email: "eduardo.vargas@ejemplo.com", first_name: "Eduardo", last_name: "Vargas"
  ),
  User.create!(email: "charles.aranguiz@ejemplo.com", first_name: "Charles", last_name: "Aránguiz"
  ),
  User.create!(email: "jorge.valdivia@ejemplo.com", first_name: "Jorge", last_name: "Valdivia"
  ),
  User.create!(email: "mauricio.isla@ejemplo.com", first_name: "Mauricio", last_name: "Isla"
  ),
  User.create!(email: "jean.beausejour@ejemplo.com", first_name: "Jean", last_name: "Beausejour"
  ),
  User.create!(email: "gonzalo.jara@ejemplo.com", first_name: "Gonzalo", last_name: "Jara"
  )
]

puts "Usuarios creados:"
users.each do |user|
  puts "  - #{user.first_name} #{user.last_name}"
end

puts "Creando chats"
chats = []
10.times do |i|
  sender = users[i]
  receiver = users[(i+1) % 10]

  chat = Chat.create!(
    sender_id: sender.id,
    receiver_id: receiver.id
  )
  chats << chat
  puts "  Chat #{i+1} creado entre #{sender.first_name} y #{receiver.first_name}"
end

puts "Creando  10 mensajes"
mensajes = [
  "¡Vamos Chile, sí se puede!",
  "La Copa América es nuestra",
  "El equipo está jugando muy bien",
  "Necesitamos ganar el próximo partido",
  "La defensa está muy sólida hoy",
  "¿Viste ese golazo?",
  "La estrategia del profe Sampaoli funciona",
  "Estamos en la final, ¡increíble!",
  "Este equipo hace historia",
  "La generación dorada a toda máquina"
]

10.times do |i|
  chat = chats[i % chats.size]
  user_id = (i % 2 == 0) ? chat.sender_id : chat.receiver_id
  sender_name = users.find { |u| u.id == user_id }.first_name

  message = Message.create!(
    chat_id: chat.id,
    user_id: user_id,
    body: "#{sender_name} dice: #{mensajes[i]}"
  )
  puts "  Mensaje #{i+1} creado: '#{mensajes[i]}' en chat #{i+1}"
end

puts "Resumen:"
puts "  - #{User.count} usuarios"
puts "  - #{Chat.count} chats"
puts "  - #{Message.count} mensajes"
