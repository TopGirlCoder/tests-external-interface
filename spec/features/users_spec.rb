require_relative '../spec_helper'
require_relative '../user'

RSpec.feature User, type: :feature do

  before(:all) { @user = User.new(first_name: 'test', last_name: 'test', phone_number: '4155551234', email: "#{Random.rand(1000)}@test#{Random.rand(1000)}.com", password: '12345678') } 
  before(:all) { @user_invalid_email = User.new(first_name: 'test', last_name: 'test', phone_number: '4155551234', email: 'test', password: '12345678') } 
  before(:all) { @user_invalid_password = User.new(first_name: 'test', last_name: 'test', phone_number: '4155551234', email: "#{Random.rand(1000)}@test#{Random.rand(1000)}.com", password: '123') } 

  feature 'visits the root page' do
    before { visit '/' }

    scenario 'with url' do
      expect(URI.parse(current_url).to_s).to eq 'http://pai-test.herokuapp.com/'
      expect(URI.parse(current_url).to_s).to_not eq 'http://non-existent-site.com'
    end 

    scenario 'with content' do
      expect(page).to have_content 'Publicity.ai'
      expect(page).not_to have_content 'non-existent-content'
    end      

    scenario 'with sign up link' do
      expect(page).to have_link 'Try It Free', href: '/users/sign_up'
      expect(page).not_to have_link 'Non existent link', href: '/users/sign_up'
    end

    scenario 'with sign in link' do 
      expect(page).to have_link 'Log in', href: '/users/sign_in'
      expect(page).not_to have_link 'Non existent link', href: '/users/sign_in'
    end    
  end 

  feature 'visits the sign up page' do
    before { visit '/users/sign_up' }

    scenario 'with url' do
      expect(URI.parse(current_url).to_s).to eq('http://pai-test.herokuapp.com/users/sign_up')
      expect(URI.parse(current_url).to_s).to_not eq 'http://non-existent-site.com'
    end  

    scenario 'with content' do
      expect(page).to have_content 'Try Publicity.ai free'
      expect(page).not_to have_content 'non-existent-content'
    end      

    scenario 'with button' do
      expect(page).to have_button 'Start Analyzing »'
      expect(page).not_to have_button 'non-existent-button'      
    end

    scenario 'with form' do
      expect(page).to have_css 'form#new_user'
      expect(page).not_to have_css 'form.non-existent-form'
    end    

    scenario 'with valid email and password' do
      @user.sign_up
      expect(page).to have_content 'Welcome! You have signed up successfully.'
      expect(page).to have_link 'Logout', href: '/users/sign_out'
      expect(page).not_to have_link 'Try It Free', href: '/users/sign_up'
      expect(page).not_to have_css 'div.flash.error' 
    end  

    scenario 'with invalid email' do
      @user_invalid_email.sign_up
      expect(page).to have_content 'Please enter a valid email address.'
    end     

    scenario 'with invalid password' do
      @user_invalid_password.sign_up
      expect(page).to have_css 'div.alert-danger'
    end           
  end

  feature 'visits the sign in page' do
    before { visit '/users/sign_in' }

    scenario 'with url' do
      expect(URI.parse(current_url).to_s).to eq 'http://pai-test.herokuapp.com/users/sign_in'
      expect(URI.parse(current_url).to_s).to_not eq('http://non-existent-site.com')
    end   

    scenario 'with content' do
      expect(page).to have_content 'Log in'
      expect(page).not_to have_content 'non-existent-content'
    end     
   
    scenario 'with button' do
      expect(page).to have_button 'Sign in'
      expect(page).not_to have_button 'non-existent-button'
    end

    scenario 'with form' do
      expect(page).to have_css 'form#new_user'
      expect(page).not_to have_css 'form.non-existent-form'
    end    
     
    scenario 'with valid email and password' do
      @user.sign_in
      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_link @user.first_name, href: '/users/edit'
      expect(page).not_to have_content 'Not signed in successfully.'
      expect(page).not_to have_button 'Sign in'
      expect(page).not_to have_css 'flash.error'
    end  

    # scenario 'with invalid email' do
    #   @user_invalid_email.sign_in
    #   expect(page).to have_css 'flash.alert'
    # end 

    scenario 'with invalid password' do
      @user_invalid_password.sign_in
      expect(page).to have_css 'div.alert-danger'
    end         
  end  

  feature 'clicks to sign out' do 
    before { visit '/users/sign_in' }

    scenario 'with link' do
      @user.sign_in
      expect(page).to have_link 'Logout', href: '/users/sign_out'            
    end 

    scenario 'and signs out' do
      @user.sign_out
      expect(page).to have_link 'Try It Free', href: '/users/sign_up'
      expect(page).to_not have_link 'Logout', href: '/users/sign_out'
      expect(page).to have_no_css 'div.flash.error'
      expect(page).not_to have_css 'div.flash.error'
    end        
  end      
end 

