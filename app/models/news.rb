# frozen_string_literal: true

class News < ApplicationRecord
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :published, -> { where("published_at <= ?", Time.current).order(published_at: :desc) }
  scope :by_category, ->(cat) { where(category: cat) if cat.present? }
  scope :by_year, ->(year) { where("strftime('%Y', published_at) = ?", year.to_s) if year.present? && year != "all" }

  def to_param
    slug
  end
end
