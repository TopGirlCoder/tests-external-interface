class User
	include Capybara::DSL

	def initialize
		@user = {
			first_name: 'Mike',
			last_name: 'Smith',
			phone_number: '415000000',
			email: 'user@test.com',
			password: '123456'
		}
	end
end		