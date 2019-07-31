class ArticlesController < ApplicationController
# layout "articles_index" ,only: [ :index]
layout "create_article", only: [:new, :update, :edit, :create]

  def index
    # @articles = Article.search(params[:search])
    @articles = Article.all
    render layout: 'articles_index'
    # if params[:search]
    #   @articles =   Article.where("lower(:title) LIKE :title",title: "%#{:search.downcase}%")
    # else
    #   @articles = Article.all
    # end

    #@articles = Article.all
    #@user = User.find(params[:user_id])
    #@article = @user.articles.find(params[:id])
  end

  def show
    #@user = User.find(params[:user_id])
    #@article = @user.articles.find(params[:id])

    @article = Article.find(params[:id])
    render layout: 'articles_index'
  end

  def new
    @article = Article.new
  end

  def edit
    #@user = User.find(params[:user_id])
    #@article = @user.articles.find(params[:id])
     @article = Article.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @article = @user.articles.create(article_params)
    #redirect_to user_article_path(@user)
    #@article = Article.new(article_params)

    if @article.save
      redirect_to user_article_path(@user,@article)
    else
      render 'new', layout: 'create_article'
    end
  end

  def update
    @user = User.find(params[:user_id])
    #@article = @user.articles.find(params[:id])
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to user_article_path(@user,@article)
    else
      render 'edit', layout: 'create_article'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    #@article = @user.articles.find(params[:id])
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to user_articles_path(@user)
  end

  private
  def article_params
    params.require(:article).permit(:title, :text, :search, :image)
  end
end
