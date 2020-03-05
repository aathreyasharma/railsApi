class AuthenticateUser
	prepend SimpleCommand

	def initialize(email, password)
		@email = email
		@password = password
	end

	def call
		JsonWebToken.encode(user_id: user.id) if user
	end

	private

	attr_accessor :email, :password

	def user
		uArr = User.collection.find({email: @email}).to_a
		if uArr.length > 0
			user = User.find(uArr[0]['_id'])
			return user if user && user.authenticate(password)
			errors.add :user_authentication, 'Vaild credentials'
			nil
		else
			errors.add :user_authentication, 'Invaild credentials'
			nil
		end
	end
end