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

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).