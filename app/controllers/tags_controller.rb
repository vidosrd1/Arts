class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy ]

  def index
    @tags = Tag.all
    @pagy, @tags = pagy(@tags)
    if params[:query].present?
      @tags = Tag.where("name LIKE ?", "%#{params[:query]}%")
    end

    if turbo_frame_request?
      render partial: "tags",
      locals: { tags: @tags }
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
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: "Tag was successfully created." }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @tag.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: "Tag was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @tag.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @tag.destroy!

    respond_to do |format|
      format.html { redirect_to tags_path, notice: "Tag was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_tag
      @tag = Tag.find(params.expect(:id))
    end

    def tag_params
      params.expect(tag: [ :name ])
    end
end
