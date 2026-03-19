# Корпоративный сайт на Ruby on Rails

Это веб-приложение на Ruby on Rails для корпоративного сайта с разделами:
- О компании (`/about`, миссия, ценности, компетенции, вакансии, контакты)
- Продукты и услуги (`/products`, `/services`)
- Опыт (`/experience`)
- Пресс-центр (`/press`, новости и статьи)

## Технологии и платформа

- `Ruby on Rails 8.1.2`
- База данных: `SQLite3`
- Веб-сервер: `Puma`
- Frontend в стиле Rails 8: `Propshaft`, `Importmap`, `Turbo`, `Stimulus`
- Фоновые и инфраструктурные сервисы Rails: `Solid Queue`, `Solid Cache`, `Solid Cable`
- Тесты: `Minitest` + `Capybara` + `Selenium WebDriver`

## Системные требования

- Ruby (рекомендуется версия, совместимая с Rails `8.1.2`)
- Bundler
- SQLite3
- Node.js не обязателен для базового запуска (используется `importmap`)

## Установка и запуск

1. Установить зависимости:
   - `bundle install`
2. Подготовить базу данных:
   - `bin/rails db:prepare`
3. Запустить приложение:
   - `bin/rails server`
4. Открыть в браузере:
   - [http://localhost:3000](http://localhost:3000)

## База данных

В проекте используется `SQLite3`:
- development: `storage/development.sqlite3`
- test: `storage/test.sqlite3`
- production: файлы в `storage/` (включая отдельные базы для cache/queue/cable)

Полезные команды:
- Создать/обновить схему: `bin/rails db:migrate`
- Заполнить начальными данными: `bin/rails db:seed`
- Сбросить и пересоздать БД: `bin/rails db:reset`

## Тестирование

- Запуск всех тестов:
  - `bin/rails test`
- Системные тесты:
  - `bin/rails test:system`

## Основные маршруты

- Главная: `/`
- О компании: `/about`
- Продукты: `/products`
- Услуги: `/services`
- Пресс-центр: `/press`
- Новости: `/press/news`
- Статьи: `/press/articles`

## Деплой

В проект подключен `Kamal`, поэтому приложение можно разворачивать как Docker-контейнер.
Базовый сценарий:
- настроить сервер и переменные окружения
- проверить конфиг деплоя
- выполнить деплой через `kamal`

## Структура проекта (кратко)

- `app/controllers/pages_controller.rb` — статические/контентные страницы
- `app/controllers/press_controller.rb` — раздел пресс-центра (новости/статьи)
- `app/models/news.rb` и `app/models/article.rb` — модели публикаций
- `app/views/` — шаблоны страниц
- `config/routes.rb` — маршруты приложения
