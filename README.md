# Paperclip Bunny.net

This gem extends [Paperclip](https://github.com/thoughtbot/paperclip) with
[Bunny.net](https://bunny.net) storage.

## Setup

Add this line to your application's Gemfile:

```ruby
gem "paperclip-bunnynet"
```

Then execute:

```
$ bundle install
```

## Usage

Configure your model to use Bunny.net storage:

```ruby
class User < ActiveRecord::Base
  has_attached_file :avatar,
    storage: :bunnynet,
    bunnynet_options: {
      storage_zone: ENV['BUNNYNET_STORAGE_ZONE'],
      api_key: ENV['BUNNYNET_API_KEY'],
      cdn_url: ENV['BUNNYNET_CDN_URL']
    }
end
```

### Configuration

The gem uses the following environment variables:

- `BUNNYNET_STORAGE_ZONE`: Your Bunny.net storage zone name
- `BUNNYNET_API_KEY`: Your Bunny.net API key
- `BUNNYNET_CDN_URL`: Your Bunny.net CDN URL (e.g., https://yourzone.b-cdn.net)

You can set these environment variables in your application or use a gem like [dotenv](https://github.com/bkeepers/dotenv) to manage them.

To verify your Bunny.net configuration, you can use the following Rake task:

```
$ rake bunnynet:verify_config
```

This task will check if all required environment variables are set and display your configuration (with the API key partially masked for security).

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

## Development and Testing

After checking out the repo, run `bin/setup` to install dependencies. 

To set up your development environment:

1. Copy the `.env.example` file to `.env`:
   ```
   cp .env.example .env
   ```

2. Edit the `.env` file and add your Bunny.net credentials.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
