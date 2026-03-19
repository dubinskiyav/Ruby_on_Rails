# frozen_string_literal: true

class PressController < ApplicationController
  def index
    redirect_to press_news_path
  end

  def news
    @news = News.published
                 .by_year(params[:year])
    @archive_years = News.where.not(published_at: nil)
                         .pluck(:published_at)
                         .map { |d| d&.strftime("%Y") }
                         .compact
                         .uniq
                         .sort
                         .reverse
  end

  def news_show
    @news_item = News.published.find_by!(slug: params[:slug])
  end

  def articles
    @articles = Article.published
  end

  def article_show
    @article = Article.published.find_by!(slug: params[:slug])
  end
end
