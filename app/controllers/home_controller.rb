class HomeController < ApplicationController
  def index
    # render 'home/index' 書かなくても良い
    @title = 'デイトラ'
  end
  
  def about
  end
end
