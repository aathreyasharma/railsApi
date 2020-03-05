class AuthenticationController < ApplicationController
	skip_before_action :authenticate_request

	def defaultAction
		msg = {msg: "Welcome to Rails API"}
		render json: msg
	end

	def signup
		res = {}

		@name = params[:name]
		@email = params[:email]
		@password = params[:password]
		@password_confirmation = params[:password_confirmation]

		uObj = User.collection.find({email: @email}).to_a
		
		if uObj.length > 0
			res['result'] = 'error'
			res['desc'] = "User with #{@email} exists!"
		else
			newUser = User.new(
					email: @email,
					name: @name,
					password: @password,
					password_confirmation: @password_confirmation
				)
			newUser.save
			res['result'] = 'success'
			res['desc'] = 'User Created'
			res['uObj'] = newUser
		end

		render json: res
	end

	def authenticate
		res = {}

		email = params[:email]
		password = params[:password]
		
		command = AuthenticateUser.call(email,password)
		
		if command.success?
			uObj = User.collection.find({email: email}).to_a
			uId = uObj[0]['_id'].to_s
			uObj[0]['_id'] = uId
			res['uObj'] = uObj[0]
			res['uObj'].delete('password_digest')
			# date = DateTime.now
			res['auth_token'] = command.result
			res['msg'] = 'success'
		else
			res['msg'] = "Authentication Failed"
			res['desc'] = "Email/Password incorrect.!!"
		end


		render json: res
	end

end