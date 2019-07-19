class CommentsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    #@article2 = @user.articles.find(params[:article_id])

    @article = Article.find(params[:article_id])
    @comment = current_user.comments.new(comment_params)
    @comment.article_id = params[:article_id]
    @comment.save
    #@article = @user.articles.find(params[:article_id])
    redirect_to user_article_path(@user,@article)
  end

  def destroy
    @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:article_id])
   #@article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
   redirect_to user_article_path(@user,@article)
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end
