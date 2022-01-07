FROM ruby:3.0.3-alpine3.14

RUN apk update && \
  apk add --virtual build-dependencies build-base sqlite sqlite-dev sqlite-libs

WORKDIR /app

COPY . /app

RUN bundle install

EXPOSE 8080

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "8080"]
