class EntriesController < ApplicationController

	def index
		render json: Entry.all.order(start: :asc)
	end

	def show
		@entry = Entry.find(params[:id])
		render json: @entry
	end

	def create
		@entry = Entry.create(start: params[:start], end: params[:end], description: params[:description], paid: false)
		render json: @entry
	end

	def update
		@entry = Entry.find(params[:id])
		@entry.update_attributes(params.permit(:paid))
		render json: @entry
	end

end
