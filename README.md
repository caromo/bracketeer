# Bracketeer

Create Swiss-style tournament brackets and view or modify them with a web UI. This was made as my senior design project for the CS program.

## Up and Running

### Dependencies

Requires Elixir, Phoenix 1.4, and PostgreSQL. Additional Hex packages used are [decimal](https://hex.pm/packages/decimal) and [random_bytes](https://hex.pm/packages/random_bytes).

### Installation

First clone and enter the repository
``` 
$ git clone https://github.com/caromo/bracketeer.git 
$ cd bracketeer    
```
Then, to get the dependencies, use ``mix deps.get`` in the bracketeer folder and ``npm install`` in assets
```
$ mix deps.get && mix deps.compile
$ cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development
```
Finally, return to bracketeer and initialize Postgres and Ecto (Make sure you have Postgres running):
```
$ cd ..
$ mix ecto.create
```

To start the app, use ``mix phx.server``, and to start up an iex session concurrently, use ``iex -S phx.server``. To run tests, use ``mix tests``
```
# Start up the server:
$ mix phx.server

# Start up the server with an iex session:
$ iex -S phx.server

# Run tests:
$ mix tests
```

If everything went as described, the server should be running locally and you can access the project in your browser at port 4000: ``localhost:4000``

## Features

Currently, Bracketeer supports:
* Swiss bracket creation
* Placement based on rating
* Rating increase/decrease per match
* Automatic generation of matches
* Access by room code
* Viewing and Editing of rooms and matches
* Testing based on Phoenix's examples using ExUnit

#### Things to improve on

* Support for more types of tournament (e.g. Elimination)
* Better UI/Styling (Currently still uses the default Phoenix styles)
* Persistent session (e.g. Going to the home page brings you to your room)
* Alternate parameters for seeding
* Rating decay
* More tests
