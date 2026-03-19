class PagesController < ApplicationController
  PRODUCTS = {
    "gelicon-erp" => { name: "Gelicon ERP", desc: "Корпоративная система управления ресурсами предприятия. Интегрированное решение для планирования, учёта и контроля бизнес-процессов." },
    "gelicon-utilities" => { name: "Gelicon Utilities", desc: "Решение для автоматизации коммунальных сетевых компаний. Комплексное решение, охватывающее основные процессы обслуживания сетевой инфраструктуры коммунальных компаний, позволяет значительно повысить эффективность работы подразделений." },
    "gelicon-conference" => { name: "Gelicon Conference", desc: "Система для организации видеоконференций и удалённого взаимодействия. Поддержка групповых совещаний, вебинаров и онлайн-презентаций." },
    "gelios" => { name: "Gelios", desc: "Платформа для построения геоинформационных систем. Визуализация и анализ пространственных данных." },
    "atlant" => { name: "Атлант", desc: "Система управления документами и документооборотом. Автоматизация процессов согласования и хранения документов." },
    "gelicon-core" => { name: "Gelicon Core", desc: "Базовая платформа для разработки корпоративных приложений. Универсальный фундамент для создания специализированных решений." },
    "kapital-cse" => { name: "Капитал CSE", desc: "Специализированное решение для управления капитальным строительством и ремонтом." }
  }.freeze

  def about
  end

  def about_mission
  end

  def about_values
  end

  def about_competencies
  end

  def about_vacancies
  end

  def about_contacts
  end

  def products
    @product_slug = nil
  end

  def product
    @product_slug = params[:slug]
    @product = PagesController::PRODUCTS[@product_slug]
    return render "product_gelicon_core" if @product_slug == "gelicon-core"
  end

  def product_gelicon_core_pricelist
    @product_slug = "gelicon-core"
    @products_subpage = "pricelist"
  end

  def services
  end

  def experience
  end

  def press
  end

  def support
  end
end
