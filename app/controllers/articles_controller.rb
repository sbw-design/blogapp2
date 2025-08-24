class ArticlesController < ApplicationController
  def index
    # render 'home/index' 書かなくても良い
    @article = Article.first
  end
  
end
