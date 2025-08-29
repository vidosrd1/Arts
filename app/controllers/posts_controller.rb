class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
    where("body LIKE ?", "%#{search}%")

   if search
    find(:all, :conditions => ['first_name LIKE ? || last_name LIKE ? || company_name LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
   else
    find(:all)
   end
  end

  def search
    if params[:post].present?
     @post = Post.search(params[:post])
    if @post #meaning if it's not nil or nothing matches the search
     render 'posts/results'
    end
    else
     flash[:danger] = "You have entered an empty search"
     redirect_to 'Home'
    end
  end

  def index
    @posts = Post.all
    @pagy, @posts = pagy(@posts)
    if params[:query].present?
@pagy, @posts = pagy(Post.search_astros(params[:query]))
#@pagy, @astros = pagy(Astro.search_astros(params[:query]))
else
  @pagy, @posts = pagy(Post.all)
  #@posts = Post.where("title LIKE ?", "%#{params[:query]}%")
    end

    if turbo_frame_request?
      render partial: "posts",
      locals: { posts: @posts }
    else
      render :index
    end

  rescue Pagy::OverflowError
    #redirect_to root_path(page: 1)
    params[:page] = 1
    retry
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
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
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
