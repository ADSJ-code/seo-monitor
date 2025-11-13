FROM ruby:3.3.3 AS builder
RUN apt-get update -qq && apt-get install -y build-essential
WORKDIR /rails
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
RUN bundle exec rails assets:precompile

FROM ruby:3.3.3-slim
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /rails
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /rails/public/assets /rails/public/assets
COPY . .
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]