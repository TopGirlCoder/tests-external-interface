class User
  include Capybara::DSL

  attr_accessor :first_name, :last_name, :phone_number, :email, :password 

  def initialize(args={})
    @first_name = args.fetch(:first_name) 
    @last_name = args.fetch(:last_name)
    @phone_number = args.fetch(:phone_number) 
    @email = args.fetch(:email)
    @password = args.fetch(:password) 
    # email: "#{Random.rand(1000)}@test#{Random.rand(1000)}.com"
  end	

  def sign_up
    visit '/users/sign_up'
    within 'form#new_user' do
      fill_in 'First name', with: @first_name
      fill_in 'Last name', with: @last_name
      fill_in 'Email', with: @email
      fill_in 'phone1', with: '415'
      fill_in 'phone2', with: '555'
      fill_in 'phone3', with: '1234'
      fill_in 'Password', with: @password
      fill_in 'Password confirmation', with: password
      click_button 'Start Analyzing »'
    end
  end	

  def sign_in
    visit '/users/sign_in'
    within 'form#new_user' do
      fill_in 'Email', with: @email
      fill_in 'Password', with: @password
      click_button 'Sign in'
    end	
  end	

  def sign_out
    click_link('Logout') if @user
  end	
end	