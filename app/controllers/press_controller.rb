# frozen_string_literal: true

# Контроллер пресс-центра: новости, статьи и страницы деталей по slug.
class PressController < ApplicationController
  def index
    redirect_to press_news_path # редиректим на страницу новостей пресс-центра
  end

  def news
    @news = News.published # берём только опубликованные новости и сортируем по дате (scope в модели)
                 .by_year(params[:year]) # дополнительно фильтруем по году из params[:year], если он передан
    @archive_years = News.where.not(published_at: nil) # оставляем записи, у которых published_at не nil
                         .pluck(:published_at) # забираем из БД только значения поля published_at (без загрузки всех объектов)
                         .map { |d| d&.strftime("%Y") } # преобразуем каждую дату в строку года "YYYY"
                         .compact # удаляем nil (на случай пустых/битых дат)
                         .uniq # убираем дублирующиеся годы
                         .sort # сортируем годы по возрастанию
                         .reverse # разворачиваем, чтобы новые годы были первыми
  end

  def news_show
    @news_item = News.published # берём только опубликованные новости
                     .find_by!(slug: params[:slug]) # ищем новость по slug из URL, 404 если не найдено
  end

  def articles
    @articles = Article.published # получаем список опубликованных статей
  end

  def article_show
    @article = Article.published # берём только опубликованные статьи
                      .find_by!(slug: params[:slug]) # ищем статью по slug из URL, 404 если не найдено
  end
end
