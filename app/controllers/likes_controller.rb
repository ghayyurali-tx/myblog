class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]

  def create
    #@user = User.find(params[:user_id])
    if already_liked?
      else
    @article.likes.create(user_id: current_user.id)
    redirect_to user_article_path(@article.user_id, @article)
    end
  end

  def destroy
   # @user = User.find(params[:user_id])
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to user_article_path(@article.user_id, @article)
  end

  private
  def find_post
    @article = Article.find(params[:article_id])
  end

  private
  def already_liked?
    Like.where(user_id: current_user.id, article_id:
        params[:article_id]).exists?
  end

  def find_like
    @like = @article.likes.find(params[:id])
  end

end
