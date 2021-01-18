# Codebreaker

This is a Codebreaker game. You break the code. That's it.
Check it on Heroku: https://secret-reaches-63131.herokuapp.com

## Technologies
Please, check [gemspec](https://github.com/vladveterok/codebreaker-gem/blob/master/codebreaker.gemspec) to see the full lisr of technologies used

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'codebreaker', git: 'https://github.com/vladveterok/codebreaker-gem.git', branch: 'develop'
```

And then execute:

    $ bundle install

Note that you can install this gem only if you have access to this private repository. Otherwise, well, sorry, mate.

## Usage

Codebreaker provides you with public interfaces you can use to operate the game:

* To initialize the game instance:
```ruby
Codebreaker::Game.new(difficulty:, user:)
```
*Example*: ```@game = Codebreaker::Game.new(difficulty: 'easy', user: @user)```
* To initialize the user instance:
```ruby
Codebreaker::User.new(name:)
```
* Difficulties provided:
```ruby
easy: { attempts: 15, hints: 2 },
medium: { attempts: 10, hints: 1 },
hell: { attempts: 5, hints: 1 }
```
* To start the game use Game instance method:
```ruby
.start_new_game
```
It'll generate a secret code of 4 numbers from 1 to 6 each and hints
* To make a guess use Game instance method:
```ruby
.guess(*string of 4 numbers from 1 to 6 each)
```
* To see hint use Game instance method:
```ruby
.show_hint
```
* To check if you won or lost use Game instance methods:
```ruby
.won?
.lost?
```
* To save your game use Game instance method:
```ruby
.save_game
```
It'll save the instance of your game session into .yml
* To load your game results from .yml file you Game **class** method:
```ruby
.load
```
It'll load all the game instances saved in .yml

**Important!** To use this gem, you have to declare two ENV variables before any interactions and requiring any dependencies. One to form the path to the .yml file where you will be saving the game and another one to name the file. Above the ENV variable you should do ```require "pathname"``` Example:
```ruby
require 'pathname'
ENV['DB_PATH'] = "#{Pathname(__FILE__).parent.dirname.realpath}/db/"
ENV['DB_FILE'] = 'results.yml'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vladveterok/codebreaker.

