namespace :rails_low_level do
  desc "Checks and outputs for Rails Low Level Cache Results"
  task check_normal: :environment do
    c = CacheManager.new
    c.check_request_rebuild
  end

  desc "Checks and outputs Rails low level cache with Delayed Job and its results"
  task check_delayed_job: :environment do
    c = CacheManager.new
    c.check_request_rebuild_with_delayed_job
  end

end
