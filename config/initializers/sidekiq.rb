if File.exist?('config/schedule.yml') && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file('config/schedule.yml')
end

require "sidekiq/throttled"
Sidekiq::Throttled.setup!