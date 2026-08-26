class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  def search
    if params[:search].blank?
      @articles = Article.all
    else
      @articles = Article.search(params)#where
    end
  end

  def search_params
    params.permit(:search_title,
      :search_name, search_body)
  end

  def index
    #@articles = Article.all
    if params[:search]
      if params[:tag_id]
        Tag.find(id).articles
      else
        @articles = Article.search(params[
      :search]).order("created_at DESC")
      end
    else
      @articles = Article.all.order('created_at DESC')
    end
    @pagy, @articles = pagy(@articles)
    if params[:query].present?
      @articles = Article.where(
        "title LIKE ?
        OR name LIKE ?",
        "%#{params[:query]}%",
        "%#{params[:query]}%").where(active: true)
    end

    if turbo_frame_request?
      render partial: "articles",
      locals: { articles: @articles }
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
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @article.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @article.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_path, notice: "Article was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_article
      @article = Article.find(params.expect(:id))
    end

    def article_params
      params.expect(article: [
        :title, :name, :tag, :image,
        :publish, :body, pictures: []
      ]).with_defaults(user: current_user)
    end

    def current_user
      User.first
    end
end
