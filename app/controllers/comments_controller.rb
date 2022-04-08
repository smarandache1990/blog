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
  
    def destroy
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      
      if ownership_check(@comment.user)
        @comment.destroy
        redirect_to article_path(@article), status: 303
      else
        redirect_to @article, status: :unprocessable_entity, notice: "#{@comment.user.name} + #{current_user.name}You cant destroy what doesn't belong to you!"
      end
    end
  
    private

      def comment_params
        params.require(:comment).permit(:commenter, :body, :status)
      end

      def ownership_check(user)
        user == current_user
      end
  end
  