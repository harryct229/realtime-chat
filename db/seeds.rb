User.delete_all
Chat.delete_all
Message.delete_all

def make_users
  10.times do |n|
    email = "user#{n+1}@gmail.com"
    password  = "123456789"
    u = User.create(
     email:    email,
     password: password,
     password_confirmation: password,
     )
    u.save
  end
  puts 'make users'
end

make_users

def make_chats
  10.times do |n|
    name = "Chat Room #{n+1}"
    u = Chat.create(
     name:    name,
     )
    u.save
  end
  puts 'make chats'
end

make_chats

puts 'seed completed'
