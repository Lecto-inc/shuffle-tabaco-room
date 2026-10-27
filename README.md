# ShuffleTabacoRoom

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/shuffle_tabaco_room`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shuffle_tabaco_room'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install shuffle_tabaco_room

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yagince/shuffle_tabaco_room.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## GitHub Actions runtime

The weekday Slack notification runs at 03:00 UTC (12:00 JST), Monday through
Friday. Manual workflow runs also send a Slack message after installation and
tests succeed. Pull requests run installation and tests without sending a Slack
message. Tests use synthetic members and a local HTTP stub; no real Slack API
calls are made by the tests.

The job uses the digest-pinned `ruby:3.4.12-bookworm` image and shell steps.
Before fetching this public repository, it updates and checks Debian's
`ca-certificates` and `libbrotli1` packages. Ruby and Bundler use the updated
system CA store. The frozen lockfile uses Bundler 2.6.9; Thor 1.5 supports the
new Ruby runtime. Application HTTP dependencies remain at their existing locked
versions.

This avoids JavaScript Actions and their separate runner-bundled Node runtime.
Changing `runs-on`, installing Node with `setup-node`, or adding a Ruby container
alongside JavaScript Actions would not select that internal Node version.
GitHub controls hosted-runner rollout: runner 2.338.2 includes Node 24.22.1,
but the runner version cannot be pinned in this workflow. The host runner and
container engine remain managed by GitHub.

When updating the container image, update its digest and review the package
minimum versions in the workflow. JavaScript Actions can be reconsidered after
verifying the actual hosted runner's internal Node and trust store are patched.
The manual checkout relies on public repository access; private repositories
would require an explicit authentication mechanism.

References:

- [Node.js October 2026 security fixes](https://nodejs.org/en/blog/vulnerability/october-2026-security-releases)
- [Runner 2.338.2 internal Node version](https://github.com/actions/runner/blob/v2.338.2/src/Misc/externals.sh)
- [GitHub container jobs](https://docs.github.com/en/actions/how-tos/write-workflows/choose-where-workflows-run/run-jobs-in-a-container)
- [Debian Brotli fix](https://security-tracker.debian.org/tracker/CVE-2026-111497)
- [eMudhra incident and offline certificate-chain checks](https://emudhra.we-have-a-problem.com/)
