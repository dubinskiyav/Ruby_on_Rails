# Деплой на Ubuntu через Docker

## 1. Подготовка сервера Ubuntu

```bash
# Обновить систему
sudo apt update && sudo apt upgrade -y

# Установить Docker
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
# Выйти и зайти снова, чтобы применить группу

# Установить Docker Compose
sudo apt install docker-compose-plugin -y
```

## 2. Клонирование репозитория

```bash
cd /opt  # или другая папка
sudo git clone https://github.com/ВАШ_ЮЗЕРНЕЙМ/ВАШ_РЕПО.git gelicon-pro
cd gelicon-pro
```

## 3. Настройка переменных окружения

```bash
# Создать .env из примера
cp .env.example .env

# Отредактировать .env — вставить RAILS_MASTER_KEY
# Ключ находится в config/master.key в вашей локальной копии
nano .env
```

Содержимое `.env`:
```
RAILS_MASTER_KEY=ваш_ключ_из_config_master_key
```

> ⚠️ **Важно:** Не добавляйте `config/master.key` в Git! Файл уже в `.gitignore`.

## 4. Сборка и запуск

```bash
# Сборка образа
docker compose build

# Запуск
docker compose up -d

# Проверка логов
docker compose logs -f web
```

Приложение будет доступно на **http://IP_СЕРВЕРА:3000**

## 5. Настройка Nginx (опционально, для порта 80)

```bash
sudo apt install nginx -y
sudo nano /etc/nginx/sites-available/gelicon
```

Конфиг:
```nginx
server {
    listen 80;
    server_name ваш_домен.ru;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

```bash
sudo ln -s /etc/nginx/sites-available/gelicon /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

## 6. Полезные команды

```bash
# Остановить
docker compose down

# Пересобрать после изменений
git pull
docker compose build --no-cache
docker compose up -d

# Логи
docker compose logs -f web

# Консоль Rails
docker compose exec web ./bin/rails console
```

## 7. Обновление приложения

```bash
cd /opt/gelicon-pro
git pull
docker compose build
docker compose up -d
```
