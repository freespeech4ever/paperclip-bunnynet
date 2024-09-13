module Paperclip
  module Bunnynet
    class Railtie < Rails::Railtie
      rake_tasks do
        load "paperclip/bunnynet/tasks.rake"
      end
    end
  end
end