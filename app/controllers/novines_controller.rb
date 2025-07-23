class NovinesController < ApplicationController
  before_action :set_novine, only: %i[ show edit update destroy ]

  def index
    #@novines = Novine.all
    @novines = Novine.all.order('created_at DESC')
    if params[:tag_id]
      Blog.find(id).novines
    else
      @novines = Novine.all.order('created_at DESC')
    end
    @pagy, @novines = pagy(@novines)
    if params[:query].present?
      @novines = Novine.where("title LIKE ?", "%#{params[:query]}%")
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
        :publish, :body, pictures: []
      ]).with_defaults(user: current_user)
    end

    def current_user
      User.first
    end
end
