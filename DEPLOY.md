# Пересборка и деплой на сервере

## Вариант 1: Kamal (рекомендуется)

Если сервер настроен через Kamal:

```bash
# Сборка образа и деплой
bin/kamal deploy

# Только пересборка без деплоя
bin/kamal build push
bin/kamal deploy
```

Перед деплоем проверьте `config/deploy.yml` — укажите IP сервера и настройте registry.

---

## Вариант 2: Docker Compose

Если на сервере используется Docker Compose:

```bash
# Подтянуть изменения
git pull

# Пересобрать образ и перезапустить
docker compose build --no-cache
docker compose up -d

# Или одной командой
docker compose up -d --build
```

---

## Вариант 3: Ручной Docker

```bash
git pull

# Собрать образ
docker build -t ruby_on_rails .

# Остановить старый контейнер
docker stop ruby_on_rails
docker rm ruby_on_rails

# Запустить новый
docker run -d -p 80:80 \
  -e RAILS_MASTER_KEY=<значение из config/master.key> \
  -v ruby_on_rails_storage:/rails/storage \
  --name ruby_on_rails \
  --restart unless-stopped \
  ruby_on_rails
```

---

## Вариант 4: Без Docker (Puma, systemd)

```bash
cd /path/to/Ruby_on_Rails

git pull
bundle install --without development test
bin/rails assets:precompile
bin/rails db:migrate  # если есть миграции

# Перезапустить приложение
sudo systemctl restart ruby_on_rails
# или
bundle exec pumactl restart
```

---

## Миграции БД

При наличии миграций:

```bash
# Kamal
bin/kamal app exec "bin/rails db:migrate"

# Docker Compose
docker compose exec web bin/rails db:migrate

# Docker
docker exec ruby_on_rails bin/rails db:migrate
```
