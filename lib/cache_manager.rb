class CacheManager

  def check_request_rebuild
    if  Rails.application.config.action_controller.perform_caching == false
      puts " >>>>>>>>> Your need to change file under => enviroments/development.rb (line 14 / 15) : "
      puts " >>>>>>>>> config.action_controller.perform_caching is #{Rails.application.config.action_controller.perform_caching}"
      puts ' >>>>>>>>> to'
      puts " >>>>>>>>> config.action_controller.perform_caching = true"

      # return
    end
    total_runs = 1
    max_runs = 21
    cache_for_seconds = 5
    run_every = 1
    slow_job_response = 8
    puts "Cache is set to expire in #{cache_for_seconds} seconds and you have set about #{max_runs} runs to test this with a 1 second gap and slow job responding in about 8 seconds"
    while total_runs <= max_runs do
      # runs = ActionController::Base.helpers.pluralize(1.ordinalize, 'run')
      force_in = "Your #{total_runs.ordinalize} request at #{Time.now}! and is from cache"

       Rails.cache.fetch("slow_job_rails_4", expires_in: cache_for_seconds.seconds) do
         force_in = slow_job total_runs, slow_job_response
       end

       puts force_in

       sleep run_every
      total_runs += 1
    end
    Rails.cache.clear
  end

  def check_request_rebuild_with_delayed_job
    if  Rails.application.config.action_controller.perform_caching == false
      puts " >>>>>>>>> Your need to change file under => enviroments/development.rb (line 14 / 15) : "
      puts " >>>>>>>>> config.action_controller.perform_caching is #{Rails.application.config.action_controller.perform_caching}"
      puts ' >>>>>>>>> to'
      puts " >>>>>>>>> config.action_controller.perform_caching = true"

      # return
    end
    task_no = DateTime.now.to_i
    total_runs = 1
    max_runs = 21
    cache_for_seconds = 5
    run_every = 1
    slow_job_response = 8
    requested_at = Time.now.utc + 300.seconds

    puts "Cache is set to expire in #{cache_for_seconds} seconds and you have set about #{max_runs} runs to test this with a #{run_every} second gap and slow job responding in about 8 seconds"
    while total_runs <= max_runs do
      # runs = ActionController::Base.helpers.pluralize(1.ordinalize, 'run')
      force_in = "Your #{total_runs.ordinalize} request at #{Time.now}! and is from cache"

       Rails.cache.fetch("slow_job_rails_4", expires_in: cache_for_seconds.seconds) do
         force_in = slow_job total_runs, slow_job_response
         requested_time = Time.now.to_i
         @job = SlowJob.create(name: task_no, description: force_in, requested_time: requested_time)
         @job.delay.update_slow_job
       end

       puts force_in

       sleep run_every
      total_runs += 1
    end
    Rails.cache.clear
  end
  private

  def slow_job total_runs = 0, slow_job_response = 8
    requested_at = Time.now.utc.to_i
    expires_at = requested_at + 5
    # sleep slow_job_response

    return "Your #{total_runs.ordinalize} request was redirected to slow request at #{Time.at(requested_at)} it responded at #{Time.at(expires_at)}! Time Stamp: #{Time.now.to_i}"
  end

  def really_slow_job

  end
end
