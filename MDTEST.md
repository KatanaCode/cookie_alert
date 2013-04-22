Here are the steps to set up the development environment:

##Setup the dummy host app:##

```bash
cd spec/dummy
bundle exec rake db:create db:migrate db:test:prepare
```

##Run the specs:##

From the root directory...

```bash
bundle exec rspec
``` 

##Run the dummy app:##

```bash
cd spec/dummy
bundle exec rails server
```