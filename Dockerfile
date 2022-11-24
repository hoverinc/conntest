# syntax=docker/dockerfile:1
FROM ruby

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY app/  ./
ENV APP_ENV=production

CMD ["bundle", "exec", "ruby", "./main.rb"]