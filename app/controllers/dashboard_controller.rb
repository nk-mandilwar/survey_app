class DashboardController < ApplicationController

	def index
		@survey = Survey.new
	end
	
end
