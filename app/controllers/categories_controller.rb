class CategoriesController < ApplicationController
  def index
    @parents = Category.all.order("id ASC").limit(13)
    # children = Category.all.where(id:14..158)
    # @children = []
    # @children[0] = Category.all.where(ancestry: 1)
    # @children[1] = Category.all.where(ancestry: 2)
    # @children[2] = Category.all.where(ancestry: 3)
    # @children[3] = Category.all.where(ancestry: 4)
    # @children[4] = Category.all.where(ancestry: 5)
    # @children[5] = Category.all.where(ancestry: 6)
    # @children[6] = Category.all.where(ancestry: 7)
    # @children[7] = Category.all.where(ancestry: 8)
    # @children[8] = Category.all.where(ancestry: 9)
    # @children[9] = Category.all.where(ancestry: 10)
    # @children[10] = Category.all.where(ancestry: 11)
    # @children[11] = Category.all.where(ancestry: 12)
    # @children[12] = Category.all.where(ancestry: 13)
    # @grandchildren = Category.all.where(id:159..1326)
  end
end
