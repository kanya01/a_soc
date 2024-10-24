# frozen_string_literal: true

class Audio < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :audio_file
  validates :title, presence: true
  # validates :audio_file, attached: true, content_type: %w[audio/mpeg audio/wav]
  ALLOWED_AUDIO_TYPES = {
    'audio/mpeg' => ['.mp3'],
    'audio/mp3' => ['.mp3'],
    'audio/wav' => ['.wav'],
    'audio/x-wav' => ['.wav'],
    'audio/aac' => ['.aac'],
    'audio/m4a' => ['.m4a'],
    'audio/x-m4a' => ['.m4a'],
    'audio/ogg' => ['.ogg'],
    'audio/flac' => ['.flac']
  }.freeze

  MAX_AUDIO_SIZE = 50.megabytes
  MIN_AUDIO_SIZE = 10.kilobytes

  validate :validate_audio_file

  private

  # validate audio file type
  def validate_audio_file
    # unless audio_file.content_type.in?(%w[audio/mpeg audio/wav/mp3//wav audio/x-wav audio/aac audio/m4a audio/x-m4a audio/ogg audio/flac])
    #   errors.add(:audio_file, "must be an MP3 or WAV file")
    return unless audio_file.attached?

    content_type = audio_file.content_type
    extension = File.extname(audio_file.filename.to_s).downcase

    unless ALLOWED_AUDIO_TYPES.key?(content_type) &&
           ALLOWED_AUDIO_TYPES[content_type].include?(extension)
      errors.add(:audio_file, 'format not supported. ' \
        'Allowed formats: MP3, WAV, AAC, M4A, OGG, FLAC')
    end
  end

  # Optional: validate file size
  # if audio_file.byte_size > 100.megabytes
  #   errors.add(:audio_file, "should be less than 100MB")
  # end
end
