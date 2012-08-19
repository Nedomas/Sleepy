class HomeController < ApplicationController

  def index
  end

  def output
  	type = params[:commit]

  	if type == 'zzz'
  		start_hour = Time.now.hour
  		start_min = Time.now.min
  		@wake_result = calculate_from_start(start_hour, start_min)
  	else 
  		end_hour = params[:hour]
  		end_min = params[:minute]
  		@sleep_result = calculate_from_end(end_hour, end_min)
  	end
  end

  def calculate_from_start(start_hour, start_min)
  	rhythm = Array.new
  	rhythm = [1.5, 3, 4.5, 6, 7.5, 9]
  	start_time = start_hour + (start_min.to_f/60)
  	times = rhythm.collect { |x| x + start_time }
  	return times
  end

  def calculate_from_end(end_hour, end_min)
  	rhythm = Array.new
  	rhythm = [1.5, 3, 4.5, 6, 7.5, 9]
  	end_time = end_hour.to_f + (end_min.to_f/60)
  	times = rhythm.collect { |x| end_time - x }
  	return times.reverse
  end
end
