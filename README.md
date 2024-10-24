# README
ASoc 

Overview
ASoc is a social media platform focused on audio sharing and interaction. Users can share audio posts, images, and engage with other users through comments and likes.
Technical Stack
Core Technologies

Ruby 3.1.2
Rails 7.1.4
PostgreSQL 14+
Node.js 18+ (for JavaScript compilation)
Yarn 1.22+ (for package management)

Key Dependencies
Production Gems
rubyCopy# Gemfile
gem 'rails', '~> 7.1.4'
gem 'pg', '~> 1.1'
gem 'puma', '~> 6.0'
gem 'devise', '~> 4.9' # Authentication
gem 'kaminari', '~> 1.2' # Pagination
gem 'image_processing', '~> 1.2' # Image processing for Active Storage
gem 'aws-sdk-s3', '~> 1.14' # AWS S3 for file storage
gem 'sidekiq', '~> 7.0' # Background job processing
gem 'redis', '~> 5.0' # Required for Sidekiq
gem 'sprockets-rails'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
Development/Test Gems
rubyCopygroup :development, :test do
gem 'rspec-rails', '~> 6.0'
gem 'factory_bot_rails'
gem 'faker'
gem 'pry-rails'
gem 'rubocop', '~> 1.60'
gem 'rubocop-rails'
gem 'brakeman' # Security analysis
gem 'bullet' # N+1 query detection
end

group :test do
gem 'shoulda-matchers'
gem 'simplecov'
gem 'capybara'
gem 'webdrivers'
end

Setup Instructions
Prerequisites

Install Ruby 3.1.2 (recommended using rbenv)
Install PostgreSQL 14+
Install Redis (for Sidekiq)
Install Node.js and Yarn

Development Environment Setup
bashCopy# Clone the repository
git clone https://github.com/yourusername/asoc.git
cd asoc

# Install dependencies
bundle install
yarn install

# Setup database
rails db:create
rails db:migrate
rails db:seed

# Start the development server
./bin/dev # This starts both Rails server and asset compilation
Running Tests
bashCopy# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/post_spec.rb

# Generate coverage report
COVERAGE=true bundle exec rspec
Project Structure
Key Components
Models

User: Handles user authentication and profile management
Post: Main content model for audio and image posts
Comment: User comments on posts
Like: User likes on posts

Controllers

PostsController: Handles post CRUD operations
CommentsController: Manages comment creation and deletion
UsersController: Handles user profile and settings

Background Jobs
Current implementation plans include:
rubyCopy# app/jobs/audio_processing_job.rb
class AudioProcessingJob < ApplicationJob
queue_as :default

def perform(post_id)
post = Post.find(post_id)
# Process audio file
# Generate waveform
# Create different format versions
end
end

# app/jobs/notification_job.rb
class NotificationJob < ApplicationJob
queue_as :notifications

def perform(user_id, notification_type, data)
user = User.find(user_id)
# Generate and send notification
end
end
Redis and Sidekiq Implementation
Configuration

Redis Setup

rubyCopy# config/initializers/redis.rb
$redis = Redis.new(
url: ENV.fetch('REDIS_URL') { 'redis://localhost:6379/1' },
timeout: 1
)

Sidekiq Setup

rubyCopy# config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
config.redis = { url: ENV.fetch('REDIS_URL') { 'redis://localhost:6379/1' } }
end

Sidekiq.configure_client do |config|
config.redis = { url: ENV.fetch('REDIS_URL') { 'redis://localhost:6379/1' } }
end

Route Configuration

rubyCopy# config/routes.rb
require 'sidekiq/web'

Rails.application.routes.draw do
authenticate :user, lambda { |u| u.admin? } do
mount Sidekiq::Web => '/sidekiq'
end
# ... other routes
end
Planned Background Jobs

Audio Processing


Format conversion
Waveform generation
Metadata extraction
Thumbnail generation


Notification System


Comment notifications
Like notifications
Mention notifications
Follow notifications


Feed Generation


User feed caching
Trending posts calculation
Featured content selection

Future Improvements
Short-term Goals

Implement audio waveform visualization
Add real-time notifications using Action Cable
Improve search functionality with Elasticsearch
Add social features (following, user discovery)
Implement post sharing functionality

Medium-term Goals

Add playlist creation and management
Implement audio effects and filters
Add direct messaging between users
Implement content moderation system
Add analytics dashboard for users

Long-term Goals

Mobile app development (React Native)
API versioning and documentation
Content recommendation system
Monetization features
Premium user features

Deployment
Production Setup
bashCopy# Required environment variables
RAILS_ENV=production
DATABASE_URL=postgresql://...
REDIS_URL=redis://...
AWS_ACCESS_KEY_ID=...
AWS_SECRET_ACCESS_KEY=...
AWS_REGION=...
AWS_BUCKET=...
Monitoring

Use Datadog or New Relic for application monitoring
Set up error tracking with Sentry
Configure logging with ELK stack

Contributing

Fork the repository
Create your feature branch (git checkout -b feature/amazing-feature)
Commit your changes (git commit -m 'Add amazing feature')
Push to the branch (git push origin feature/amazing-feature)
Open a Pull Request

License
This project is licensed under the MIT License - see the LICENSE.md file for details