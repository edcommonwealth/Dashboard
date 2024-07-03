# Dashboard
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "dashboard", git: "https://github.com/edcommonwealth/Dashboard"
```

And then execute:
```bash
$ bundle
```

And install the migrations:
```bash
./bin/rails dashboard:install:migrations
```

Run the migration:
```bash
./bin/rails db:migrate
```

Mount the engine to your desired route:
```bash
  mount Dashboard::Engine, at: "dashboard"
```

Navigate to the dashboard page:
If run in development: 
```
http://localhost:3000/dashboard/welcome
```

Install javascript bundler
```bash
./bin/rails javascript:install:esbuild
```

Install css bundler
```bash
./bin/rails css:install:bootstrap
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the GPL v3 license
