# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts 'Cleaning database...'
Comment.destroy_all
Audio.destroy_all
Post.destroy_all
User.destroy_all

puts 'seeding users..'
10.times do |i|
  user = User.create!(
    username: Faker::Internet.unique.username(specifier: 5..10),
    email: Faker::Internet.unique.email,
    password: 'password123',
    password_confirmation: 'password123'
  )
  puts "created user #{i + 1}: #{user.username}"
end

# test user for dev and test
user = User.create!(
  username: 'testuser',
  email: 'r5z7Z@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)
puts "created test user:{#{user.username}}"

puts 'attaching audios to users..'
# helper method to attach audio files
# def attach_audio_file(audio)
audio_path = Rails.root.join('spec', 'fixtures', 'test_aaudio.mp3')

# If the test audio doesn't exist, create a dummy file
# system("dd if=/dev/zero of=#{audio_path} bs=1024 count=1024") unless File.exist?(audio_path)

# attach the test audio file to the audio object and attach the audio file
# audio.audio_file.attach(
#   io: File.open(audio_path),
#   filename: 'test_aaudio.mp3',
#   content_type: 'audio/mp3'
# )
# puts "done attaching audio: #{audio.title}"
# end

# seed audios
puts 'seeding audios..'
User.all.each do |user|
  rand(2..5).times do |i|
    audio = user.audios.create!(
      title: Faker::Music.album,
      description: Faker::Lorem.paragraph
    )
    file_data = File.read(audio_path)
    audio.audio_file.attach(
      # io: File.open(audio_path),
      io: StringIO.new(file_data),
      filename: 'test_aaudio.mp3',
      content_type: 'audio/mp3'
    )
    # puts "done attaching audio: #{audio.title}"
    # attach_audio_file(audio)
    if audio.save
      puts "created audio #{i + 1} for user: #{user.username}"
    else
      puts "failed to create audio #{i + 1} for user: #{user.username}"
    end
  rescue StandardError => e
    puts "error creating audio: #{e}"
  end
end

# seed comments
puts 'seeding comments..'
Audio.all.each do |audio|
  rand(2..5).times do |i|
    commenter = User.all.sample
    audio.comments.create!(
      content: Faker::Lorem.sentence,
      user: commenter
    )
    puts "created comment #{i + 1} for audio: #{audio.title}"
  end
end

# seed posts
puts 'seeding posts..'
User.all.each do |user|
  rand(2..5).times do |i|
    post = user.posts.create!(
      content: Faker::Lorem.paragraphs(number: 3).join("\n\n")
    )

    # placeholder image
    width = rand(300..800)
    height = rand(200..600)
    post.image.attach(
      io: URI.open("https://picsum.photos/#{width}/#{height}"),
      filename: "post_image_#{post.id}.jpg",
      content_type: 'image/jpeg'
    )
    puts "created post #{i + 1} for user: #{user.username}"
  rescue OpenURI::HTTPError
    puts "Failed to attach image for post #{i + 1}"
  end
end

puts "- #{User.count} users"
puts "- #{Audio.count} audio posts"
puts "- #{Comment.count} comments"
puts "- #{Post.count} blog posts"
