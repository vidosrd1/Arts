class NovinesController < ApplicationController
  before_action :set_novine, only: %i[ show edit update destroy ]

  def search
    if params[:search].blank?
      @novines = Novine.all
    else
      @novines = Novine.search(params)#where
    end
  end

  def index
    #@novines = Novine.all
    if params[:search]
      if params[:tag_id]
        Blog.find(id).novines
      else
        @novines = Novine.search(params[
      :search]).order("created_at DESC")
      end
    else
      @novines = Novine.all.order('created_at DESC')
    end
    @pagy, @novines = pagy(@novines)
    if params[:query].present?
      @novines = Novine.where(
        "title LIKE ?
        OR name LIKE ?",
        "%#{params[:query]}%",
        "%#{params[:query]}%")
    end

    if turbo_frame_request?
      render partial: "novines", locals: { articles: @articles }
    else
      render :index
    end
  rescue Pagy::OverflowError
    #redirect_to root_path(page: 1)
    params[:page] = 1
    retry
  end

  def index1
    #@articles = params[:q].present? ?
    #Article.search(params[:q]) :
    #Article.all
    @novines = params[:q].present? #?
    if params[:q]
      #if params[:tag_id]
      #  Blog.find(id).novines
      #else
        @novines = Novine.order('created_at DESC').
        search('search query').records
        #search(params[:search])
      #end
    else
      @novines = Novine.order('created_at DESC').all
    end
    #Novine.search(params[:q]) : Novine.all
    #if params[:search]
    @pagy, @novines = pagy(@novines)
    #if params[:query].present?
    if params[:q].present?
      @novines = Novine.where(
        "title LIKE ?
        OR name LIKE ?
        OR body LIKE ?",
        "%#{params[:q]}%",
        "%#{params[:q]}%",
        "%#{params[:q]}%")#.where(active: true)
    end

    if turbo_frame_request?
      render partial: "novines", locals: { articles: @articles }
    else
      render :index
    end
  rescue Pagy::OverflowError
    #redirect_to root_path(page: 1)
    params[:page] = 1
    retry
  end

  def show
    #@novine = Novine.find(params[:id])
    #fresh_when etag: @novine
  end

  def new
    @novine = Novine.new
  end

  def edit
  end

  def create
    @novine = Novine.new(novine_params)

    respond_to do |format|
      if @novine.save
        format.html { redirect_to @novine, notice: "Novine was successfully created." }
        format.json { render :show, status: :created, location: @novine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @novine.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @novine.update(novine_params)
        format.html { redirect_to @novine, notice: "Novine was successfully updated." }
        format.json { render :show, status: :ok, location: @novine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @novine.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @novine.destroy!

    respond_to do |format|
      format.html { redirect_to novines_path, status: :see_other, notice: "Novine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_novine
      @novine = Novine.find(params.expect(:id))
    end

    def novine_params
      params.expect(novine: [ #:user_id,
        :title, :name, :blog, :image,
        :publish, :body,
        :superpower_id, :search,
        pictures: []
      ]).with_defaults(user: current_user)
    end

    def current_user
      User.first
    end
end
