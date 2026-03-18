# Скрипт установки Ruby on Rails и создания проекта
# Запустите PowerShell от имени администратора для установки Ruby

$ErrorActionPreference = "Stop"

Write-Host "=== Установка Ruby on Rails ===" -ForegroundColor Cyan

# Проверка Ruby
try {
    $rubyVersion = ruby -v 2>$null
    if ($rubyVersion) {
        Write-Host "Ruby уже установлен: $rubyVersion" -ForegroundColor Green
    }
} catch {
    Write-Host "Ruby не найден. Устанавливаю через Chocolatey..." -ForegroundColor Yellow
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        choco install ruby -y
        Write-Host "`nВАЖНО: Закройте и откройте новый терминал, затем запустите этот скрипт снова." -ForegroundColor Red
        exit 0
    } else {
        Write-Host "Chocolatey не установлен. Скачайте Ruby с https://rubyinstaller.org/downloads/" -ForegroundColor Red
        exit 1
    }
}

# Установка Rails
Write-Host "`nПроверка Rails..." -ForegroundColor Cyan
try {
    $railsVersion = rails -v 2>$null
    if ($railsVersion) {
        Write-Host "Rails уже установлен: $railsVersion" -ForegroundColor Green
    }
} catch {
    Write-Host "Устанавливаю Rails..." -ForegroundColor Yellow
    gem install rails
}

# Создание проекта
Write-Host "`nСоздание Rails проекта..." -ForegroundColor Cyan
$projectPath = "C:\WORK\Programming\Ruby_on_Rails"
Set-Location $projectPath

if (Test-Path "config\application.rb") {
    Write-Host "Проект уже создан." -ForegroundColor Green
} else {
    rails new . --force
    Write-Host "Проект создан успешно!" -ForegroundColor Green
}

Write-Host "`nГотово! Запустите сервер командой: rails server" -ForegroundColor Green
Write-Host "Откройте в браузере: http://localhost:3000" -ForegroundColor Cyan
