# ASoc 🎵
> Modern audio-first social platform built with Rails 7

[![Ruby Version](https://img.shields.io/badge/ruby-3.1.2-brightgreen.svg)](https://ruby-lang.org)
[![Rails Version](https://img.shields.io/badge/rails-7.1.4-brightgreen.svg)](https://rubyonrails.org)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.md)

## ✨ Features

- 🎵 Audio post sharing with waveform visualization
- 📸 Image attachment support
- 💬 Real-time comments and interactions
- 👥 User profiles and authentication
- 📱 Responsive design with Tailwind CSS

## 🚀 Quick Start

### Prerequisites

- Ruby 3.1.2
- PostgreSQL 14+
- Redis 7+
- Node.js 18+
- Yarn 1.22+

### Setup

```bash
# Clone and install dependencies
git clone https://github.com/yourusername/asoc.git
cd asoc
bundle install
yarn install

# Setup database
rails db:setup

# Start development servers
./bin/dev
```

## 💎 Key Dependencies

### Production
```ruby
gem 'rails', '~> 7.1.4'
gem 'devise'        # Authentication
gem 'sidekiq'       # Background jobs
gem 'redis'         # Caching & Sidekiq
gem 'aws-sdk-s3'    # File storage
```

### Development/Test
```ruby
gem 'rspec-rails'
gem 'factory_bot_rails'
gem 'rubocop-rails'
gem 'bullet'        # N+1 query detection
```

## 🏗️ Architecture

### Core Components

```
app/
├── controllers/    # Request handling
├── jobs/          # Background processing
├── models/        # Business logic
└── views/         # UI templates
```

### Background Processing

Sidekiq for handling:
- Audio processing & waveform generation
- Notification delivery
- Feed generation
- Content moderation

```ruby
# Example job structure
class AudioProcessingJob < ApplicationJob
  queue_as :default
  
  def perform(post_id)
    # Process audio file
    # Generate waveform
  end
end
```

## 🔄 Redis Integration


Redis powers the following features:
- Background job queues (Sidekiq)
- Caching layer
- Real-time features
- Session storage

### Configuration

```ruby
# config/redis.yml
production:
  url: <%= ENV.fetch("REDIS_URL") %>
  timeout: 1
```

## 🎯 Roadmap

### Phase 1 
- [x] Core audio sharing
- [x] User authentication
- [x] Basic interactions
- [ ] Waveform visualization
- [ ] Real-time notifications
- [ ] Docker containerization
- [ ] CI pipeline setup

### Phase 2 
- [ ] Playlists
- [ ] Audio effects
- [ ] Direct messaging
- [ ] Content moderation
- [ ] AWS Infrastructure Setup
- [ ] S3 for media storage
- [ ] Analytics dashboard

### Phase 3 - 
- [ ] Mobile app (React Native)
- [ ] API documentation
- [ ] Performance optimization
- [ ] Recommendation system
- [ ] Premium features
- [ ] Monetization

## 🧪 Testing

```bash
# Run test suite
bundle exec rspec

# With coverage
COVERAGE=true bundle exec rspec
```

## 🚀 Deployment

Required environment variables:
```bash
RAILS_ENV=production
DATABASE_URL=postgresql://...
REDIS_URL=redis://...
AWS_ACCESS_KEY_ID=...
AWS_BUCKET=...
```

## 📈 Monitoring

- Application: Datadog/New Relic
- Error tracking: Sentry
- Logging: ELK stack

## 🤝 Contributing

1. Fork it
2. Create feature branch
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. Commit changes
   ```bash
   git commit -m 'Add amazing feature'
   ```
4. Push to branch
   ```bash
   git push origin feature/amazing-feature
   ```
5. Create Pull Request

## 📝 

[MIT License](LICENSE.md)



---

Built with  by Moses Mwangi
