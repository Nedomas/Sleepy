class HomeController < ApplicationController
	respond_to :html, :js

  def index
  end

  def output
  	type = params[:commit]

  	if type == 'zzz'
  		@wake_result = calculate_from_now
  	else 
  		end_hour = params[:hour]
  		end_min = params[:minute]
      if end_hour.empty? && end_min.empty?
        @wake_result = calculate_from_now
      else
        end_time_in_seconds = (end_hour.to_i.hours + end_min.to_i.minutes)
        end_time = Time.at(end_time_in_seconds).utc
        @sleep_result = calculate_from_end(end_time)
      end
  	end
  	respond_to do |format|
      format.html
      format.js
    end
  end

  def clean
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def calculate_from_now
  	rhythm = Array.new
  	rhythm = [1.5, 3, 4.5, 6, 7.5, 9]
  	times = rhythm.collect { |x| Time.now.in_time_zone("Vilnius").advance(:hours => x, :minutes => 14) }
  	return times.reverse
  end

  def calculate_from_end(end_time)
  	rhythm = Array.new
  	rhythm = [1.5, 3, 4.5, 6, 7.5, 9]
  	times = rhythm.collect { |x| end_time.advance(:hours => -x, :minutes => -14) }
  	return times.reverse
  end
end
