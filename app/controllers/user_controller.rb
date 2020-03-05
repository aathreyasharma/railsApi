class UserController < ApplicationController

	def getUser
		res = {}

		uId = params[:uId]
		
		uObj = User.find(uId)
		if !uObj.nil?
			newObj = {
				_id: uObj['_id'].to_s,
				email: uObj['email'],
			}
			res['uObj'] = newObj
			res['desc'] = "User Found"

		else
			res['desc'] = 'User unavailable'
		end
		
		render json: res
	end


end