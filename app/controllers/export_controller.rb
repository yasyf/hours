require 'csv'

class ExportController < ApplicationController
	Time::DATE_FORMATS[:csv] = lambda { |time| time.strftime("%d/%m/%Y %I:%M%p") }
	UTC_OFFSET = -4
	
	def index
		if params[:start] && params[:end]
			start = Time.at(params[:start].to_i / 1000).to_datetime
			_end = Time.at(params[:end].to_i / 1000).to_datetime
			entries = Entry.where(created_at: (start.._end))
		else
			entries = Entry.where(paid: false)
		end

		offset = params[:offset].to_i || UTC_OFFSET
		

		csv_string = CSV.generate do |csv|
		  csv << ["Description", "Start", "End", "Hours"]
		  hours = 0
		  entries.each do |entry|
		  	hour = ((entry.end - entry.start) / 1.hour).round
		  	csv << [entry.description, (entry.start + offset.minute).to_formatted_s(:csv), (entry.end + offset.minute).to_formatted_s(:csv), hour]
		  	hours += hour
		  end
		  csv << ['Total', nil, nil, hours]
		end

		entries.update_all(paid: true)
		render text: csv_string
	end
end
