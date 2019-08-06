class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to user_article_path(@user,@article=Article.find_by_user_id(@user)) }
      format.js
    end
    # @article = Article.find(params[:followed_id])
    # redirect_to user_article_path(@article.user_id,@user)
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    # @article = Article.find(params[:followed_id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to user_article_path(@user,@article=Article.find_by_user_id(@user)) }
      format.js
    end

    # redirect_to user_article_path(@article.user_id,@user)
  end

end
