FactoryBot.define do

  factory :user do
    nickname              {"watashi"}
    first_name           {"myouji"}
    last_name            {"name"}
    kana_first_name      {"ワタシ"}
    kana_last_name       {"ツバサ"}
    email                 {"kkk@gmail.com"}
    password              {"1234567"}
    password_confirmation {"1234567"}
    birthday_year         {"1990"}
    birthday_manth        {"4"}
    birthday_day          {"11"}
    tel_number            {"09049032435"}
    ken                   {"大阪府"}
    map                   {"羽曳野市"}
    build                 {"羽曳野市"}
    banchi                {"1-1-1"}
    postl_code            {"583-0886"}


  end

end