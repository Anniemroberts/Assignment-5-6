class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action(:find_post, { only: [:show, :edit, :destroy, :update] })
  before_action :authorize, only: [:edit, :destroy, :update]

  def index
    @posts = Post.order(created_at: :desc)
  end

# before_action(:find_post, { only: [:show, :edit, :destroy, :update] })

def new
  @post = Post.new
end

def create
  @post  = Post.new(post_params)
  @post.user = current_user
  if @post.save
    flash[:notice] = 'Post created successfully'
    redirect_to post_path(@post)
  else
    flash.now[:alert] = 'Please fix errors below'
    render :new
  end
end

def show
  #@post = Post.find params[:id]
  @comment = Comment.new
end

def edit
  #@post = Post.find params[:id]
  if current_user != @question.user
  redirect_to root_path, alert: 'Not authorized'
  end
end

def update
  #@post = Post.find params[:id]
  if @post.update post_params
    redirect_to post_path(@post)
  else
    render :edit
  end
end

def destroy
#@post = Post.find params[:id]
@post.destroy
redirect_to posts_path, notice: 'Post deleted!'
end

private

def post_params
  # this feature is called strong parameters (introduced in Rails 4+)
  params.require(:post).permit([:title, :body, :category_id])
end


def find_post
  @post = Post.find params[:id]
end

def authorize
  if cannot?(:manage, @post)
  redirect_to root_path, alert: 'Not authorized!'
  end
end

end
