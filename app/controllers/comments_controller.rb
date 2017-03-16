class CommentsController < ApplicationController
  def create
  comment_params = params.require(:comment).permit(:body, :name)
  @comment = Comment.new comment_params
  @post = Post.find params[:post_id]
  @comment.post = @post
  if @comment.save
    #AnswersMailer.notify_question_owner(@answer).deliver_later
    CommentsMailer.notify_post_owner(@comment).deliver_now
    redirect_to post_path(params[:post_id]), notice: 'Comment created!'
  else
    flash.now[:alert] = 'please fix errors'
    render 'posts/show'
  end
end

def destroy
  comment = Comment.find params[:id]
  comment.destroy
  redirect_to post_path(comment.post_id), notice: 'Comment deleted!'
end
end
