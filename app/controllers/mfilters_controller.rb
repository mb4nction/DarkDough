class MfiltersController < ApplicationController
  def create
		filter_id = params[:mfilter][:filter_id]
		filter = current_user.mfilters.find_by_filter_id(filter_id)
		filter.delete unless filter == nil
		filter = Mfilter.new(params[:mfilter])
		if filter.save
			ret = 'success'
		else
			ret = 'failed'
		end
		render :json=>{:status=>ret, :data_id=>filter.id} and return
  end
	
	def destroy
		id = params[:id]
		filter = current_user.mfilters.find(id)
		filter.delete
		render :text=>'success' and return
	end
end
