class HomeController < ApplicationController
  def index
    # render 'home/index' 書かなくても良い
    @article = Article.first
  end
  
  def about
  end
end
