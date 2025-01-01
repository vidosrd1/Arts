class BloggablesController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]

  def index
    @blogs = Bloggables.all
    #Novine novines = @blogs.novines# = Novine novines
    @pagy, @blogs = pagy(@blogs)
    if params[:query].present?
      @blogs = Bloggables.where("novine LIKE ?", "%#{params[:query]}%")
    end

    @pagy, @blogs.novines = pagy(@blogs.novines)
    if params[:query].present?
      #.@blogs.novines
      @blogs.novines = Blog.novines.where("title LIKE ?", "%#{params[:query]}%")
      #@pagy.blog.novines.count > @pagy.blog.novines.items %>
      #pagy_nav(@pagy.blog.novines) %>
    end

    if turbo_frame_request?
      render partial: "blogs",
      locals: { blogs: @blogs }
    else
      render :index
    end

  rescue Pagy::OverflowError
    #redirect_to root_path(page: 1)
    params[:page] = 1
    retry
  end

  def show
    @novine = Novine.order('created_at DESC').find(params[:id])
    if params[:blog]
      @novines = Novine.tagged_with(params[:blog])
      @blog = @novines
    end
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy!

    respond_to do |format|
      format.html { redirect_to blogs_path, status: :see_other, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_blog
      @bloggable = Bloggable.find(params.expect(:id))
    end

    def blog_params
      params.expect(bloggable: [ :novine_id, :blog_id ])
    end
end
