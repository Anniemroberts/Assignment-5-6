class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_like, only: [:destroy]
  before_action :create_find_post, only: [:create]
  before_action :delete_find_post, only: [:destroy]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.liked_posts
  end


  def create
    if cannot? :like, @post
      redirect_to post_path(@post), alert: 'Liking your own post isn\'t allowed'
      return
    end

    like = Like.new(user: current_user, post: @post)

    if like.save
      redirect_to post_path(@post), notice: 'Review liked! 💙'
    else
      redirect_to post_path(@post), alert: 'Couldn\'t like post! 💔'
    end
  end


  def destroy
    if cannot? :like, @like.post
      redirect_to post_path(@post), alert: 'Un-liking your own post isn\'t allowed'
      return
    end

    redirect_to(
      post_path(@post),
      @like.destroy ? {notice: 'post un-liked! 💔'} : {alert: @like.errors.full_messages.join(', ')}
    )
  end


  private


  def find_like
    @like ||= Like.find(params[:id])
  end

  def delete_find_post
    @post ||= Post.find params[:id]
  end

  def create_find_post
    @post ||= Post.find params[:post_id]
  end

end
