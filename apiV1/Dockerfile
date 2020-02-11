FROM circleci/ruby:2.5.1-stretch-node-browsers

# Install required packages
RUN sudo apt-get update && sudo apt-get -y install  \
    bash-completion

RUN ruby -r bundler -r bundler/setup -e 'puts Bundler::VERSION'

USER root
RUN mkdir -p rubyapp
WORKDIR rubyapp/

ENV RAILS_ENV development
ENV DOCKER 1
ENV REDIS_PROVIDER "redis://redis:6379/0"

COPY . /rubyapp

RUN gem install bundler
RUN gem update bundler

RUN chmod 755 /rubyapp/start_docker.sh

RUN bundle install

EXPOSE 3000

# Start the main process.
CMD ["./start_docker.sh"]
