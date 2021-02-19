FROM ruby:2.7.2

# Install yarn and node
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update && apt-get install -y yarn nodejs

WORKDIR /home/puppy/application
COPY ./recipe_puppy /home/puppy/application/

RUN gem install bundler
RUN bundle install
RUN yarn install --check-files
CMD ["rails", "server", "-b", "0.0.0.0"]