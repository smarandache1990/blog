class ArticlesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
    @articles = Article.all.order(:created_at => :desc)
  end

  def show
    @article = Article.find(params[:id])
    @article.update(views: @article.views + 1)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])

    if ownership_check(@article.user)
      @article.destroy
      redirect_to root_path, status: :see_other
    else
      redirect_to @article, status: :unprocessable_entity, notice: "You cant destroy what doesn't belong to you!"
    end

  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end

    def ownership_check(user)
      true ; false if user == current_user
    end
    
end
