# Import::Issues

This will take cards from a Trello board and import them into GitHub as issues with the option of leaving them open or marking them as closed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'import-issues'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install import-issues

## Usage

To use you will need your GitHub login credentials and your Trello key & token (found here: https://trello.com/app-key).
Then you can run ./exe/import-issues import to begin the process.

Warning: This code has not been tested - use at your own risk.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/newmanships/import-issues. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Import::Issues project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/newmanships/import-issues/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2018 Jesse Newman. See [MIT License](LICENSE.txt) for further details.