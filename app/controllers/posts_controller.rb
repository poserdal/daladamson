class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @posts = Post.all
  end


  def show
  end


  def new
    @post =  current_user.posts.build
  end


  def edit
  end


  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'YO! Your post was successfully created!'
    else
      render action: 'new'
    end
  end


  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.' 
    else
      render action: 'edit' 
    end
  end


  def destroy
    @post.destroy
    redirect_to posts_url
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Makes sure users can't delete an other's post
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to posts_path, notice: "Sorry dude, you're not authorized to edit this pin" if @post.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :image, :body, :published)
    end
end
