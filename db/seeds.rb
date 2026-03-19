# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Новости с https://www.gelicon.biz/news

# Полные тексты для первых 5 новостей (со страниц «Читать далее»)
FULL_BODIES = {
  "razrabotka-interaktivnyh-form" => "Под конец года завершаются большинство проектов, в том числе происходит сдача интерактивных форм для портала госуслуг некоторых регионов.\n\nВ частности, в этом году наша компания разрабатывала десятки интерактивных форм для Курской и Иркутской областей.",
  "gosuslugi-habarovsk" => "Уже 6 лет мы сотрудничаем с Хабаровском, помогая им в решении разных вопросов с порталом госуслуг. В 2025 году мы также сделали ряд доработок портала, в том числе были произведены изменения в функциональности взаимодействия портала с ЕСИА.",
  "erp-kapital-cse-rybinsk" => "На протяжении уже почти 25 лет мы сотрудничаем с кабельными заводами России. В свое время на базе нашего продукта ERP-системы Капитал CSE было создано решение по комплексной автоматизации кабельных заводов, в том числе автоматизации процессов производственного планирования и оперативного управления производством.\n\nВ 2025 году мы возобновили сотрудничество с ведущим производителем кабельной промышленности Рыбинским кабельным заводом.",
  "rgmu-dagestana" => "Наше сотрудничество с Республикой Дагестан длится уже много лет.\n\nВ этом году мы занимались традиционными для нашей компании задачами — сопровождали Реестр государственных и муниципальных услуг (функций) Республики Дагестан, обеспечением его работоспособности.\n\nВ этой сфере мы работаем с 16 регионами Российской Федерации на протяжении почти 12 лет.",
  "kpd-proekt" => "Система KPD Проект начала создаваться в мае 2024 года по индивидуальному заказу компании ГСК Инжиниринг.\n\nЗадача компании — создать уникальный в своем роде сервис для создания проектной документации и управления ею.\n\nСистема была запущена в промышленную эксплуатацию и работает по модели SAAS по ссылке konstruktorpd.ru\n\nСервис позволяет автоматизировать процессы проектирования для ускорения разработки документов, включает в себя необходимые унифицированные шаблоны, генерирует отчеты и чертежи. Все это снижает риск ошибок в документации.\n\nРазвитие системы и наше сотрудничество с ГСК Инжиниринг продолжается."
}.freeze

# Специальные slug для первых 5 новостей
SPECIAL_SLUGS = {
  0 => "razrabotka-interaktivnyh-form",
  1 => "gosuslugi-habarovsk",
  2 => "erp-kapital-cse-rybinsk",
  3 => "rgmu-dagestana",
  4 => "kpd-proekt"
}.freeze

def slug_from_title_and_date(_title, date_str, index)
  return SPECIAL_SLUGS[index] if SPECIAL_SLUGS[index]

  day, month, year = date_str.split(".")
  "news-#{year}-#{month}-#{day}-#{index}"
end

require_relative "news_data"
require_relative "articles_data"
news_data = NEWS_DATA
articles_data = ARTICLES_DATA

# Обновляем или создаём записи по slug. Добавленные на сервере вручную — не трогаем.
news_data.each_with_index do |(date_str, title, summary), index|
  slug = slug_from_title_and_date(title, date_str, index)
  body = FULL_BODIES[slug] || summary

  News.find_or_initialize_by(slug: slug).tap do |n|
    n.assign_attributes(
      title: title,
      summary: summary,
      body: body,
      published_at: Time.zone.parse(date_str.split(".").reverse.join("-")),
      category: "news"
    )
    n.save!
  end
end

articles_data.each do |date_str, title, summary, slug|
  Article.find_or_initialize_by(slug: slug).tap do |a|
    a.assign_attributes(
      title: title,
      summary: summary,
      body: summary,
      published_at: Time.zone.parse(date_str.split(".").reverse.join("-"))
    )
    a.save!
  end
end
