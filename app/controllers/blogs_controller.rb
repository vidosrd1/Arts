class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]

  def blogs
    @novine = Novine.find(params[:id])
  end

  def index
    #@blogs = Blog.all
    if params[:search]
      if params[:tag_id]
        Novine.find(id).blogs
      else
        @blogs = Blog.order('created_at').
        #order('created_at DESC').
        search(params[:search])
      end
    else
      @blogs = Blog.order('created_at')#.order('created_at DESC')
    end
    #if params[:search]
    #  @blogs = Blog.search(params[
    #:search]).order("created_at DESC")
    #else
    #  @blogs = Blog.all.order('created_at DESC')
    #end
    #Novine novines = @blogs.novines
    @pagy, @blogs = pagy(@blogs)
    if params[:query].present?
      @blogs = Blog.change(
        "name LIKE ? ",
        "%#{params[:query]}%"
      ).where(active: true)
    end
    #@pagy, @blogs = pagy(@blogs)
    #if params[:query].present?
    #  @blogs = Blog.where("name LIKE ?",
    #    "%#{params[:query]}%")
    #end
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
    @novines = Novine.order('created_at DESC')
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
      @blog = Blog.find(params.expect(:id))
    end

    def blog_params
      params.expect(blog: [ :name, :novines ])
    end
end
