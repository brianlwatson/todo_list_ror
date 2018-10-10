FROM ruby:2.3
ENV APP_HOME /usr/src/app
WORKDIR $APP_HOME

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY . $APP_HOME/
EXPOSE 3000

CMD ["bundle","exec","rails","server","-b","0.0.0.0"]
