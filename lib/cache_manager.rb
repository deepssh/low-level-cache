class CacheManager

  def check_request_rebuild
    if  Rails.application.config.action_controller.perform_caching == false
      puts " >>>>>>>>> Your need to change file under => enviroments/development.rb (line 14 / 15) : "
      puts " >>>>>>>>> config.action_controller.perform_caching is #{Rails.application.config.action_controller.perform_caching}"
      puts ' >>>>>>>>> to'
      puts " >>>>>>>>> config.action_controller.perform_caching = true"

      # return
    end
  total_runs = 0
  cache_for_seconds = 11
    while total_runs < 11 do
      puts "You have Requested at #{Time.now}! this is #{total_runs} run and cache would expire in #{cache_for_seconds} seconds"
       Rails.cache.fetch("slow_job_rails_4", expires_in: cache_for_seconds.seconds) do
         slow_job
         sleep 5
       end
       sleep 5
      total_runs += 1
    end
  end
  private

  def slow_job
    requested_at = Time.now.utc.to_i
    expires_at = requested_at + 5
    sleep 5
    puts "Cache Refreshed => your slow request was at #{Time.at(requested_at)} it responded at #{Time.at(expires_at)}!"
  end

  def really_slow_job

  end
end
