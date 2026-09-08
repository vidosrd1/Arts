class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    #@posts = Post.all
    if params[:search]
      @posts = Post.search(params[
    :search]).order("created_at DESC")
    else
      @posts = Post.all.order('created_at DESC')
    end
    @pagy, @posts = pagy(@posts)
    if params[:query].present?
      @posts = Post.change(
        "title LIKE ? OR
        name LIKE ? OR
        body LIKE ?",
        #body::text LIKE ?",
        "%#{params[:query]}%",
        "%#{params[:query]}%",
        "%#{params[:query]}%"
      ).where(active: true)
    end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @post.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @post.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params.expect(:id))
    end

    def post_params
      params.expect(post: [ :title,
    :name, :image, :body ])
    end
end
