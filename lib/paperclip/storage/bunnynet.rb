require 'uri'
require 'net/http'
require 'json'

module Paperclip
  module Storage
    module Bunnynet
      def self.extended(base)
        base.instance_eval do
          @bunnynet_options = @options[:bunnynet_options] || {}
          @bunnynet_storage_zone = ENV['BUNNYNET_STORAGE_ZONE']
          @bunnynet_api_key = ENV['BUNNYNET_API_KEY']
          @bunnynet_cdn_url = ENV['BUNNYNET_CDN_URL']
          @bunnynet_storage_url = ENV['BUNNYNET_STORAGE_URL'] || 'https://storage.bunnycdn.com'
        end
      end

      def exists?(style_name = default_style)
        url = bunnynet_url(style_name)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Head.new(url.path)
        request["AccessKey"] = @bunnynet_api_key
        response = http.request(request)
        response.code.to_i == 200
      end

      def public_exists?(style_name = default_style)
        url = URI.parse(public_url(style_name))
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Head.new(url.path)
        response = http.request(request)
        response.code.to_i == 200
      end

      def copy_to_local_file(style, local_dest_path)
        url = bunnynet_url(style)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(url.path)
        request["AccessKey"] = @bunnynet_api_key
        response = http.request(request)
        
        if response.is_a?(Net::HTTPSuccess)
          File.open(local_dest_path, 'wb') do |file|
            file.write(response.body)
          end
        else
          raise "Failed to download file from Bunny.net: #{response.code} - #{response.message}"
        end
      end

      def flush_writes
        @queued_for_write.each do |style_name, file|
          url = bunnynet_url(style_name)
          # check an environment variable, BUNNYNET_SKIP_IF_EXISTS, and if true, check exists? first.
          if ENV['BUNNYNET_SKIP_IF_EXISTS'] && public_exists?(style_name)
            puts "paperclip-bunnynet: Skipping upload for #{path(style_name)} because it already exists."
            next
          end
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true
          request = Net::HTTP::Put.new(url.path)
          request["AccessKey"] = @bunnynet_api_key
          request.body = file.read
          response = http.request(request)
          
          unless response.is_a?(Net::HTTPSuccess)
            raise "Failed to upload file to Bunny.net: #{response.code} - #{response.message}"
          end
        end
        @queued_for_write = {}
      end

      def flush_deletes
        @queued_for_delete.each do |path|
          url = URI.parse("#{@bunnynet_storage_url}/#{@bunnynet_storage_zone}/#{path}")
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true
          request = Net::HTTP::Delete.new(url.path)
          request["AccessKey"] = @bunnynet_api_key
          response = http.request(request)
          
          unless response.is_a?(Net::HTTPSuccess)
            raise "Failed to delete file from Bunny.net: #{response.code} - #{response.message}"
          end
        end
        @queued_for_delete = []
      end

      def bunnynet_url(style_name = default_style)
        path = path(style_name)
        URI.parse("#{@bunnynet_storage_url}/#{@bunnynet_storage_zone}/#{path}")
      end

      def public_url(style_name = default_style)
        path = path(style_name)
        "#{@bunnynet_cdn_url}/#{path}"
      end
    end
  end
end