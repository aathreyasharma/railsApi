class ApplicationController < ActionController::API
    before_action :authenticate_request
    attr_reader :current_user
  
  	# ActionController::Parameters.permit_all_parameters = true
  	ActionController::Parameters.permit_all_parameters = true

  	private

  	def authenticate_request

      # p request.headers
    	@current_user = AuthorizeApiRequest.call(request.headers).result
    
	    res = {
	    		result: "error",
	    		desc: 'Not Authorized'
	    	}

    	render json: res, status: 401 unless @current_user
  	end
end
