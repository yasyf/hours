class EntriesController < ApplicationController

	@entry = Entry.find(params[:id])

	def index
		render json: Entry.all
	end

	def show
		render json: @entry
	end


end
