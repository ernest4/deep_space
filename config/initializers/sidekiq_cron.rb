Sidekiq.configure_server do |_config|
  periodic_job_data = {
    # :some_worker => {
    #   :cron => "3-59/5 * * * *", # Every 5 minutes after 3 min
    #   :class => "SomeWorker",
    #   :queue => "default"
    # },
  }
  Sidekiq::Cron::Job.load_from_hash!(periodic_job_data)
end
