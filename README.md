# README

This is the backend to get the exchange rates over time for ARS-USD.

To run this project you will need:

* Ruby version: 3.0 or higher
* Rails

* System dependencies:
  * Postgres database running. Configure connection string on database.yml
  * Sidekiq running: this allows to run a job that will fetch exchange rates every 10 minutes.
  * Whenever: this allows to set up a cron job on the machine that will run the job to fetch exchange rates.
  * Redis running: whenever will enqueue the job into a redis, and sidekiq will fetch the job from the queue and hit the endpoint.

Steps to run this project:
1. Create a new postgres database and configure the connection.
2. Run rails migrations into the db using `rails db:migrate`.
3. Run `whenever --update-crontab` to set up the cron job in your computer.
4. Run `bundle exec sidekiq` to start running sidekiq jobs. You can check it's running at `http://0.0.0.0:3000/sidekiq/`.
5. Verify everything is running. Every 10 minutes the job will hit the endpoint to fetch the new exchange rates. You can run the job yourself in the rails console (enter with `rails console`) and then running `FetchDolarDataJob.perform_now`.
6. Hit the endpoint `http://0.0.0.0:3000/dolar` to get the current rate. Hit `http://0.0.0.0:3000/dolar` to get the rates over time.