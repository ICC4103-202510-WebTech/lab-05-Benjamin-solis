
Message.delete_all
Chat.delete_all
User.delete_all

10.times do |i|
  User.create(
    email: "student#{i}@uandes.cl",
    first_name: "Student",
    last_name: "Number#{i}"
  )
end

puts "Created #{User.count} users"

users = User.all
10.times do |i|
  Chat.create(
    sender_id: users[i].id,
    receiver_id: users[(i+1) % 10].id
  )
end

puts "Created #{Chat.count} chats"

chats = Chat.all
10.times do |i|
  chat = chats[i % 10]
  Message.create(
    chat_id: chat.id,
    user_id: chat.sender_id,
    body: "This is message #{i+1} from a student project"
  )
end

puts "Created #{Message.count} messages"
