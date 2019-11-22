crumb :root do
  link "メルカリ ", root_path
end

crumb :mypage do
  link "マイページ", user_path
end


#ログアウト
crumb :logout do
  link "ログアウト", logout_user_path
  parent :mypage
end

# 本人情報
crumb :identification do
  link "本人情報", identification_user_path
  parent :mypage
end


crumb :payment do
  link "支払方法", payment_user_path
  parent :mypage
end

crumb :sending do
  link "取引方法", sending_user_path
  parent :mypage
end
crumb :profile do
  link "プロフィール", edit_user_path
  parent :mypage
end

crumb :status_sell do
  link "出品した商品ー出品中", status_sell_user_path
  parent :mypage
end

crumb :status_trading do
  link "出品した商品ー取引中", status_trading_user_path
  parent :mypage
end
crumb :status_sold do
  link "出品した商品ー売却済", status_sold_user_path
  parent :mypage
end
crumb :status_delivery do
  link "購入した商品ー取引中", status_delivery_user_path
  parent :mypage
end
crumb :status_bought do
  link "購入した商品ー過去の取引", status_bought_user_path
  parent :mypage
end

crumb :show do
  link "商品出品画面", item_path
  parent :status_sell
end

