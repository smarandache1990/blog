class CommentsController < ApplicationController
    before_action :authenticate_user!
    #http_basic_authenticate_with name: "dhh", password: "secret", only: :destory

    def new
      @comment = Comment.new
    end

    def create
      @article = Article.find(params[:article_id])
      @comment = @article.comments.new(comment_params)
      @comment.user = current_user
      @comment.save
      redirect_to article_path(@article)
    end

    def edit
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
    end

    def update
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])

      if @comment.update(comment_params)
        redirect_to @article
      else
        redirect_to :edit, status: :unprocessable_entity
      end
    end
    
  
    def destroy
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      
      if ownership_check(@comment.user)
        @comment.destroy
        redirect_to article_path(@article), status: 303
      else
        redirect_to @article, status: :unprocessable_entity, notice: "You cant destroy what doesn't belong to you!"
      end
    end
  
    private

      def comment_params
        params.require(:comment).permit(:commenter, :status, :body)
      end

      def ownership_check(user)
        user == current_user
      end
  end
  