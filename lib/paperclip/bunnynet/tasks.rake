namespace :bunnynet do
  desc "Verifies your Bunny.net configuration"
  task :verify_config do
    required_env_vars = %w(BUNNYNET_STORAGE_ZONE BUNNYNET_API_KEY BUNNYNET_CDN_URL)
    missing_vars = required_env_vars.select { |var| ENV[var].nil? || ENV[var].empty? }

    if missing_vars.empty?
      puts "Bunny.net configuration verified successfully:"
      puts "Storage Zone: #{ENV['BUNNYNET_STORAGE_ZONE']}"
      puts "CDN URL: #{ENV['BUNNYNET_CDN_URL']}"
      puts "API Key: #{ENV['BUNNYNET_API_KEY'][0,4]}#{'*' * (ENV['BUNNYNET_API_KEY'].length - 4)}"
    else
      puts "Error: Missing required environment variables:"
      missing_vars.each { |var| puts "  - #{var}" }
      puts "\nPlease set these variables in your environment or .env file."
    end
  end
end