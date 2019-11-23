crumb :root do
  link("メルカリ ", root_path)
end
crumb :show do
  link("マイページ", user_path)
end
crumb :logout do
  link("ログアウト", logout_user_path)
  parent :show
end
crumb :identification do
  link("本人情報", identification_user_path)
  parent :show
end
crumb :payment do
  link("支払方法", payment_user_path)
  parent :show
end
crumb :sending do
  link("取引方法", sending_user_path)
  parent :show
end
crumb :edit do
  link("プロフィール", edit_user_path)
  parent :show
end
crumb :status_sell do
  link("出品した商品ー出品中", status_sell_user_path)
  parent :show
end
crumb :status_trading do
  link("出品した商品ー取引中", status_trading_user_path)
  parent :show
end
crumb :status_sold do
  link("出品した商品ー売却済", status_sold_user_path)
  parent :show
end
crumb :status_delivery do
  link("購入した商品ー取引中", status_delivery_user_path)
  parent :show
end
crumb :status_bought do
  link("購入した商品ー過去の取引", status_bought_user_path)
  parent :show
end