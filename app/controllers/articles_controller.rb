class ArticlesController < ApplicationController

  def index
    @user = User.find(current_user.id)
    @article = Article.new
    @articles = Article.all
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to article_path(@article)
    else
      render :index
    end
  end

  def show
    @article = Article.find(params[:id])
    new_history = @article.browsing_histories.new
    new_history.user_id = current_user.id
    if current_user.browsing_histories.exists?(article_id: "#{params[:id]}")
      old_history = current_user.browsing_histories.find_by(article_id: "#{params[:id]}")
      old_history.destroy
    end
    histories_stock_limit = 10
    histories = current_user.browsing_histories.all
    if histories.count > histories_stock_limit
      histories[0].destroy
    end
    new_history.save
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to articles_path
    else
      render :edit
    end
  end

  def destroy
    article = Article.find(params[:id])
    if article.delete
      redirect_to articles_path
    else
      render :show
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :topic, :user_id)
  end
end
