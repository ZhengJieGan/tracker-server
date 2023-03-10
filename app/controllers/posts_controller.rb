class PostsController < ApplicationController
  include Kaminari::PageScopeMethods
  before_action :set_post, only: %i[ show edit update destroy ]
  protect_from_forgery unless: -> { request.format.json? }
  
  # To create a new model
  # bin/rails g scaffold Post title:string body:text
  # bin/rails g scaffold Comment name:string message:string post:belongs_to

  # GET /posts or /posts.json
  def index
    page = params[:page] || 1
    @posts = Post.where(user_id: $user_id._id).page(params[:page].to_i).per(5)
    @total_posts =  @posts.count
    render json: { posts: @posts.as_json(include: :comments), total_posts: @total_posts }, headers: { 'Access-Control-Allow-Origin' => '*' }
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @posts = Post.where(user_id: @post.user_id )

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render json: @posts.as_json(include: :comments), status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @posts = Post.all
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render json: @posts.as_json(include: :comments), status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    @posts = Post.where(user_id: @post.user_id )

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { render json: @posts.as_json(include: :comments) }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end

    def current_user
      # This is where you would retrieve the current user object from your authentication system.
      # For example:
      User.find_by(_id: session[:user_id])
    end
end
