FROM ruby:2.5

WORKDIR /usr/src/app

RUN apt-get update && apt-get -y upgrade

COPY Gemfile Gemfile.lock ./
RUN bundle install

CMD ["irb", "-r", "./src/main.rb"]