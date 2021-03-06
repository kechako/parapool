# Parapool

Provides parallel processing on thread pool.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'parapool'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install parapool

## Usage

```ruby
pool = Parapool.new
pool.map([1, 2, 3, 4, 5]).map do |data|
  data ** 2
end
# => [1, 4, 9, 16, 25]
```

## Contributing

1. Fork it ( https://github.com/kechako/parapool/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
