# Preserva Backend

[![Maintainability](https://api.codeclimate.com/v1/badges/dd1b7d7ab2db9c83d0cd/maintainability)](https://codeclimate.com/github/covid-preservar/preservar-app/maintainability)

## Links uteis

| Website | Url  |
| :-----: | :--: |
| Trello | https://trello.com/b/zpQaUrDr/preserva |
| Figma | https://www.figma.com/proto/dvBM9mvf85fpcEg8zp8tCh/Preservar?node-id=2725%3A1&viewport=453%2C523%2C0.125&scaling=scale-down-width |


## Requirements

- Ruby 2.6.5
- PostgreSQL 12
- Memcache
- Redis

## Environment file

Copy `.env.example` file in the root of repository to `.env` and set the various environment variables
needed to function.

## Seeds

`seeds.rb` is meant for DB seeds that will be used in production. For seeding the DB for development, use the `populate.rake` task.

## Procfile and Procfile.dev

> TL;DR: Run `foreman start` in one terminal and `rails server` in another.

Since `foreman` doesn't play too well with breakpoints, it's best to run `rails server` separately from the rest of the processes (`postgres`, `memcache`, `redis` and `worker`)

However, Heroku uses Procfile to determine process formation, but in Heroku we only need `web` and `worker` processes, so we have a `Procfile` for use in Heroku and `Procfile.dev` to be used locally.

The `.foreman` file should make `foreman` automatically pick up `Procfile.dev` instead of `Procfile`.
