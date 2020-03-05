class JsonWebToken
	class << self

		def encode(payload)
			JWT.encode(payload,  Rails.application.secrets.secret_key_base)
		end

		def decode(payload)
			body = JWT.decode(payload, Rails.application.secrets.secret_key_base)[0]
			HashWithIndifferentAccess.new body
		rescue
			nil
		end

	end

end