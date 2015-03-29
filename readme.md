# SiteMapper

Чтобы запустить сайт нужно:
- запустить ./run.sh
## или
- bundle install
- rake db:create
- rake db:migrate
- Запустить локально редис `redis-server`
- Запустить Sidekiq для бекграунд задач `bundle exec sidekiq`
- И запустить сервер

