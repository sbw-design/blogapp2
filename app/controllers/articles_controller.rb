class ArticlesController < ApplicationController
  before_action :set_article, only: [:show,]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    # render 'home/index' 書かなくても良い
    @articles = Article.all
  end

  def show
    @comments = @article.comments 
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to article_path(@article), notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # 必ず自分の記事しか編集できないようにする'current_user.articles'
    @article = current_user.articles.find(params[:id])
  end

  def update
    # 必ず自分の記事しか更新できないようにする'current_user.articles'
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: '更新しました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # 必ず自分の記事しか削除できないようにする'current_user.articles'
    article = current_user.articles.find(params[:id])
    article.destroy!
    redirect_to root_path, status: :see_other, notice: '削除しました'
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :eyecatch)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
