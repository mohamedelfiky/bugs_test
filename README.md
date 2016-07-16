# README [![Code Climate](https://codeclimate.com/github/mohamedelfiky/bugs_test/badges/gpa.svg)](https://codeclimate.com/github/mohamedelfiky/bugs_test) [![Test Coverage](https://codeclimate.com/github/mohamedelfiky/bugs_test/badges/coverage.svg)](https://codeclimate.com/github/mohamedelfiky/bugs_test/coverage) [![Build Status](https://travis-ci.org/mohamedelfiky/bugs_test.svg?branch=master)](https://travis-ci.org/mohamedelfiky/bugs_test)

Example API application built on top of Ruby on Rails using TDD/BDD techniques.

Provided API backbone can be easely extended and versioned, clients should use HTTP header to specify version (`Accept: application/vnd.instabug.api.v1`), or default version will be used.

## Local setup
**prerequisite mysql, redis, elasticsearch and rabbitmq**

Copy the local_database.sample.yml to local_database.yml and change local database configration, then run `./bin/setup` after cloning this repo. It will install all dependencies, create database and setup rabbitMQ routing `rake rabbitmq:setup`.

This application uses `sqlite3` for tests in order to simplify testing process.

## Server
Use `rails s && WORKERS=BugsWorker rake sneakers:run` or just `foreman start` (if you have `foreman` installed locally) to run application server.


## Testing
You are free to use `rake`, `rake spec` or even `rspec` command to run test suite against whole application.

## API objects and methods
### Bugs
#### JSON representation
```json
{
    "number": 1,
    "status": "new_bug|in_progress|closed",
    "priority": "minor|major|critical",
    "memory": 1024,
    "os": "IOS 9",
    "storage": 1024,
    "device": "Iphone 6"
}
```

#### Available actions
All support `x-application-token` as header param to identitfy current Application.
- **List Bugs**  
  `GET /bugs` 
    Supports `page`and `q` params.
- **Count Bugs**  
  `GET /bugs/count`  
- **Create new Bug**  
   `POST /bugs`
    Expects these params (status, priority, state_attributes: (memory, storage, device, os).
- **Information by bug number**  
  `GET /bugs/:number`



