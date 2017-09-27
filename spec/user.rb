class User
  include Capybara::DSL
  
  attr_accessor :user, :first_name 

	def initialize
		@user = { first_name: 'test', 
							last_name: 'test', 
							phone_number: '4155551234', 
							email: "#{Random.rand(1000)}@test#{Random.rand(1000)}.com", 
							password: '12345678' 
						}
	end	

	def sign_up
		within 'form#new_user' do
			fill_in 'First name', with: @user[:first_name]
			fill_in 'Last name', with: @user[:last_name]
			fill_in 'Email', with: @user[:email]
			fill_in 'phone1', with: '415'
			fill_in 'phone2', with: '555'
			fill_in 'phone3', with: '1234'
			fill_in 'Password', with: @user[:password]
			fill_in 'Password confirmation', with: @user[:password]
      click_button 'Start Analyzing »'
    end
	end	

	def sign_in
		within 'form#new_user' do
			fill_in 'Email', with: @user[:email]
			fill_in 'Password', with: @user[:password]
			click_button 'Sign in'
		end	
	end	

	def sign_out
		if @user 
			click_link('Logout')
		end
	end	
end	