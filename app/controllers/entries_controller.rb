class EntriesController < ApplicationController

	def index
		render json: Entry.all
	end

	def show
		@entry = Entry.find(params[:id])
		render json: @entry
	end

	def create
		@entry = Entry.create(start: params[:start], end: params[:end], description: params[:description])
		render json: @entry
	end


end
