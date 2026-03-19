#
# DEPLOY.md
#
# Деплой на сервере — полная инструкция

## Docker Compose

Подключитесь к серверу по SSH и выполните:

```bash
# 1. Перейти в папку проекта
cd /opt/gelicon-pro

# 2. Подтянуть код
git pull

# 3. Собрать образ и запустить
docker compose up -d --build

# 4. Миграции (создать таблицы)
docker compose exec web bin/rails db:migrate

# 5. Загрузить новости (при первом деплое или для обновления)
docker compose exec web bin/rails db:seed
```

**Перед первым запуском:** создайте файл `.env` с переменной `RAILS_MASTER_KEY` (скопируйте значение из `config/master.key`).

---

## Краткая шпаргалка

```bash
git pull
docker compose up -d --build
docker compose exec web bin/rails db:migrate
docker compose exec web bin/rails db:seed
```
