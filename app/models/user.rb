# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :audios, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true

  def avatar_url
    if avatar.attached?
      # Rails.application.routes.url_helpers.rails_blob_path(avatar, only_path: true)
      Rails.application.routes.url_helpers.url_for(avatar)
    else
      # ActionController::Base.helpers.asset_path('default_avatar.png')
      "https://ui-avatars.com/api/?name=#{CGI.escape(username)}&size=100"
    end
  end

  def initials
    return '' if email.blank?

    # Extract first character of email (before @)
    first_initial = email.split('@').first[0]

    # Return uppercase initial
    first_initial.upcase
  end
end
