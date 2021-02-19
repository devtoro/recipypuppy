# README

# This is a Dockerized Rails application, named RecipePuppy.
** It is set up to run only in development and test env, NOT FOR production

- Shows recipies from http://www.recipepuppy.com/about/api/
- Searches recipies by utilising http://www.recipepuppy.com/about/api/

** Ruby version: 2.7.2

** Built with Ruby on Rails, version: ~> 6.1.3

## System dependencies
  - Docker
  - docker-compose (version 3.8)

## How to run the application with docker
```bash
docker-compose up

docker-compose exec web bundle exec rake db:setup
```
Then depending on your system configuration,
either visit the IP of the manosagent/recipepuppy:1.1 container on port 3000
or localhost on port 3000.

If you are using the dockerapp, just visit localhost:3000

## Without docker
- CD to the movie_rama directory
- run:
```bash
bundle install
```

```bash
bundle exec rake db:setup
bundle exec rails s
```

** You need to have ruby 2.7.2 installed along with the bundler gem

## How to run the test suite
- With docker
```bash
docker-compose exec -e RAILS_ENV=test -e HUB_URL=http://chrome:4444/wd/hub web bundle exec rspec
```
- Withour docker
after you have run
```bash
bundle install
bundle exec rake db:create
```

run the command:
```bash
bundle exec rspec
```


