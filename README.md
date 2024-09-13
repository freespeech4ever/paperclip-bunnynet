# Paperclip Bunny.net

This gem extends [Paperclip](https://github.com/thoughtbot/paperclip) with
[Bunny.net](https://bunny.net) storage.

## Setup

Add this line to your application's Gemfile:

```ruby
gem "paperclip-bunnynet", github: "freespeech4ever/paperclip-bunnynet"
```

Then execute:

```
$ bundle install
```

## Usage

Configure your application to use Bunny.net storage, in `config/initializers/paperclip.rb`:

```ruby
Paperclip::Attachment.default_options[:storage] = :bunnynet
```

### Configuration

The gem uses the following environment variables:

- `BUNNYNET_STORAGE_ZONE`: Your Bunny.net storage zone name
- `BUNNYNET_API_KEY`: Your Bunny.net API key
- `BUNNYNET_CDN_URL`: Your Bunny.net CDN URL (e.g., https://yourzone.b-cdn.net)
- `BUNNYNET_STORAGE_URL`: Your Bunny.net storage URL (default: https://storage.bunnycdn.com)

You can set these environment variables in your application or use a gem like [dotenv](https://github.com/bkeepers/dotenv) to manage them.

The `BUNNYNET_STORAGE_URL` is optional and allows you to specify a custom storage URL if needed. If not set, it defaults to "https://storage.bunnycdn.com".

### The `:path` option

To change the path of the file, use Paperclip's `:path` option:

```ruby
:path => ":style/:id_:filename"  # Defaults to ":filename"
```

### URL options

To get the public URL of an attachment:

```ruby
user.avatar.url
```

### Check if the file exists

To check if a file exists on Bunny.net:

```ruby
user.avatar.exists?
# user.avatar.exists?(style)
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
