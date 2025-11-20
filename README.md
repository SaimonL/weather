# README

Weather App written in Ruby 3.4.7 with Rails 7.2.3. 
With this app you can enter a zip code, and this app will use a 3rd party API to retrieve weather for that location. 
The app uses redis service to cache the API response for 30 minutes.

## Setup

Before we get started you will need to set some environment variables.

- SECRET_KEY_BASE (for production)
- DB_HOST (default: localhost)
- DB_PORT (default: 5432)
- DB_USER (default: postgres)
- DB_PASSWORD
- REDIS_URL (default: redis://localhost:6379/0)
- WEATHER_API_KEY

This app does not use database however, the Postgres database is ready to be used if needed.
So you will need a postgres server to run the initial migration.

### Weather API Key

I am using [Weather API](https://www.weatherapi.com/) 3rd party service.
You can signup and get an API key that gives you 1 million api calls a month for free.
You can visit their [doc](https://www.weatherapi.com/docs/) section for more details. 

The code for the API call is located in folder: "app/services/weather_api_service/"  

The configuration is located: "config/initializers/weather_api.rb"  
You can change the cache minutes by changing `WEATHER_CACHE_TTL_MINUTES`.  
You can also change the version `WEATHER_API_VERSION`. Currently, it only has v1.


## Test

RSpec is used. You can run it by executing `bin/rspec` or `bundle exec rspec`.
Once you are done running the test, see the coverage "coverage/rspec.html".
