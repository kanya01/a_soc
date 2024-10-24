class RenameAudioToAudioFile < ActiveRecord::Migration[7.1]
  def change
    def change
      rename_column :active_storage_attachments, :name, :audio_file
      where(name: 'audio')
    end
  end
end
