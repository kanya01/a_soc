# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one_attached :audio_file
  validates :content, presence: true
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  def location
    "#{city}, #{country}" if city.present? && country.present?
  end

  def image_url
    return nil unless image.attached?

    if Rails.application.config.action_controller.default_url_options[:host]
      Rails.application.routes.url_helpers.url_for(image)
    else
      Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
    end
  end

  # def likes_count
  #   likes.count
  # end
  def comments_count
    comments.count
  end
  def audio_url
    Rails.application.routes.url_helpers.rails_blob_path(audio_file, only_path: true) if audio_file.attached?
  end
end
