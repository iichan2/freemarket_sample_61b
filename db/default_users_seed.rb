require 'csv'
default_users = CSV.read('./db/users/default_users.csv', headers: true)

hashs = []
default_users.each do |data|
  hash = {
    first_name:"#{data["first_name"]}",
    last_name:"#{data["last_name"]}",
    kana_first_name:"#{data["kana_first_name"]}",
    kana_last_name:"#{data["kana_last_name"]}",
    nickname:"#{data["nickname"]}",
    tel_number:"#{data["tel_number"]}",
    likes:"#{data["likes"]}",
    comments:"#{data["comments"]}",
    reviews:"#{data["reviews"]}",
    birth_year:"#{data["birth_year"]}", 
    birth_month:"#{data["birth_month"]}",
    birth_day:"#{data["birth_day"]}",
    profile:"#{data["profile"]}",
    email:"#{data["email"]}",
    provider:"#{data["provider"]}",
    uid:"#{data["uid"]}",
  }
  hashs << hash
end

User.create!(hashs)
