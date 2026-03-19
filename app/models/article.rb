# frozen_string_literal: true

class Article < ApplicationRecord
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :published, -> { where("published_at <= ?", Time.current).order(published_at: :desc) }

  def to_param
    slug
  end
end
