# Use the official Ruby image
FROM ruby:3.2.2

# Install OS dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \                
  nodejs \
  yarn \
  postgresql-client         

# Set environment variables
ENV RAILS_ENV=development \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

# Set working directory
WORKDIR /app

# Copy Gemfiles
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the entire application
COPY . .

# Expose Rails default port
EXPOSE 3000

# Start the Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
