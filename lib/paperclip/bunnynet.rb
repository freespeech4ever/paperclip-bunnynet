require "paperclip"
require "paperclip/storage/bunnynet"

module Paperclip
  module Bunnynet
    def self.extended(base)
      base.instance_eval do
        @options[:url] = ":bunnynet_public_url" if @options[:url].nil? || @url == ":bucket_path"
        @options[:path] = ":filename" if @options[:path].nil?
      end
    end
  end
end

# Register Bunnynet storage with Paperclip
# Paperclip::Storage.register(:bunnynet, Paperclip::Storage::Bunnynet)

# Load rake tasks if Rails is defined
if defined?(Rails)
  require "paperclip/bunnynet/railtie"
end