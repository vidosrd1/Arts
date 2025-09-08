class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy ]

  def search
    if params[:search].blank?
      @articles = List.all
    else
      @articles = List.search(params)#where
    end
  end

  def search_params
    params.permit(:search_title,
      :search_name, search_body)
  end

  def index
    if params[:search]
      @lists = List.search(params[
    :search]).order("created_at DESC")
    else
      @lists = List.all.order('created_at DESC')
    end
    @pagy, @lists = pagy(@lists)
    if params[:query].present?
      @lists = List.change(
        "title LIKE ?
        name LIKE ? OR
        body LIKE ?",
        #body::text LIKE ?",
        "%#{params[:query]}%",
        "%#{params[:query]}%",
        "%#{params[:query]}%"
      ).where(active: true)
    end

    if turbo_frame_request?
      render partial: "lists",
      locals: { lists: @lists }
    else
      render :index
    end

  rescue Pagy::OverflowError
    #redirect_to root_path(page: 1)
    params[:page] = 1
    retry
  end

  #@search = params["search"]
  #if @search.present?
  #  @title = @search["title"]
  #end

  #if ?q == nil
  #  @lists = Lists.find(10)
  #else
  #  @lists = List.all.order('created_at DESC')
  #end
  #end
  #@lists = List.all.order('created_at DESC')
  #@pagy, @lists = pagy(@lists)
  def show
  end

  def new
    @list = List.new
  end

  def edit
  end

  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: "List was successfully updated." }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list.destroy!

    respond_to do |format|
      format.html { redirect_to lists_path, status: :see_other, notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_list
      @list = List.find(params.expect(:id))
    end

    def list_params
      params.expect(list: [ :title,
        :name, :art_id, :image, :body,
        :superpower_id, :search ])
    end
end
