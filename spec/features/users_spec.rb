require_relative '../spec_helper'
require_relative 'user'

# Capybara::Session.new :selenium_chrome

RSpec.describe User, type: :feature do

	before(:all) { @user = User.new } 

	context 'given root page' do
		before { visit '/' }

		context 'with url' do
		
			scenario 'should be true if navigates to root page' do
				expect(URI.parse(current_url).to_s).to eq 'http://pai-test.herokuapp.com/'
				expect(URI.parse(current_url).to_s).to_not eq 'http://non-existent-site.com'
			end 

			scenario 'should be false if navigates to root page' do
				expect(URI.parse(current_url).to_s).to_not eq 'http://non-existent-site.com'
			end 
		end
		
		context 'with content, "Publicity.ai"' do

			scenario 'should be true if directs to the page with content' do
				expect(page).to have_content 'Publicity.ai'
			end     

			scenario 'should be false if directs to page with given content' do
				expect(page).not_to have_content 'non-existent-content'
			end 
		end

		context 'with link for user to sign up' do 

			scenario 'should be true if sign up link is on the page' do
				expect(page).to have_link 'Try It Free', href: '/users/sign_up'
			end

			scenario 'should be false if the given sign up link is not on the page' do
				expect(page).not_to have_link 'Non existent link', href: '/users/sign_up'
			end 
		end
		
		context 'with link for user to sign in' do 

			scenario 'should be true if sign in link is on the page' do 
				expect(page).to have_link 'Log in', href: '/users/sign_in'
			end 

			scenario 'should be false if the given sign in link is not on the page' do
				expect(page).not_to have_link 'Non existent link', href: '/users/sign_in'
			end 
		end   
	end 

	context 'given sign up page' do

		before { visit '/users/sign_up' }
		
		context 'with url' do
			scenario 'should be true if directs to page with url' do
				expect(URI.parse(current_url).to_s).to eq('http://pai-test.herokuapp.com/users/sign_up')
			end  

			scenario 'should be false if directs to page with given url' do
				expect(URI.parse(current_url).to_s).to_not eq 'http://non-existent-site.com'
			end 
		end  
	
		context 'with content' do

			scenario 'should be true if page has content' do
				expect(page).to have_content 'Try Publicity.ai free'
			end     

			scenario 'should be false if page has given content' do
				expect(page).not_to have_content 'non-existent-content'
			end 
		end

		context 'with button' do

			scenario 'should be true if sign up button to submit form is on page' do
				expect(page).to have_button 'Start Analyzing »'
			end

			scenario 'should be false if the given button is not on page' do
				expect(page).not_to have_button 'non-existent-button'
			end 
		end  

		context 'with form' do
			
			scenario 'should be true if form to sign up is on page' do
				expect(page).to have_css 'form#new_user'
			end   

			scenario 'should be false if the given form to sign up is not on page' do
				expect(page).not_to have_css 'form.non-existent-form'
			end  
		end
		
		context 'with successful sign up' do 
			
			scenario 'should be true if page has content' do
				@user.sign_up

				expect(page).to have_content 'Welcome! You have signed up successfully.'
				expect(page).not_to have_link 'Try It Free', href: '/users/sign_up'
				expect(page).to have_link 'Logout', href: '/users/sign_out'
				expect(page).to have_no_css 'div.flash.error' 
			end  

			scenario 'should be false if given input is valid' do
				@user.sign_up
					
				expect(page).to have_css 'div.alert-danger' 
			end  
		end
	end

	context 'given sign in page' do
		
		before { visit '/users/sign_in' }

		context 'with url' do
			scenario 'should be true if directs to page with url' do
				expect(URI.parse(current_url).to_s).to eq 'http://pai-test.herokuapp.com/users/sign_in'
			end   

			scenario 'should be false if directs to page with given url' do
				expect(URI.parse(current_url).to_s).to_not eq('http://non-existent-site.com')
			end 
		end  
	
		context 'with content' do

			scenario 'should be true if page has content' do
				expect(page).to have_content 'Log in'
			end     

			scenario 'should be false if page has given content' do
				expect(page).not_to have_content 'non-existent-content'
			end 
		end

		context 'with button' do

			scenario 'should be true if sign in button to submit form is on page' do
				expect(page).to have_button 'Sign in'
			end

			scenario 'should be false if the given button is not on page' do
				expect(page).not_to have_button 'non-existent-button'
			end 
		end  

		context 'with form' do
			
			scenario 'should be true if form to sign in is on page' do
				expect(page).to have_css 'form#new_user'
			end   

			scenario 'should be false if the given form to sign in is not on page' do
				expect(page).not_to have_css 'form.non-existent-form'
			end  
		end 
		
		context 'with successful sign in' do 
			
			scenario 'should be true if page has content' do
				@user.sign_in

				expect(page).to have_content 'Signed in successfully.'
			end 

			scenario 'should be false if page has given content' do
				expect(page).not_to have_content 'Not signed in successfully.'
			end 

			scenario 'should be true if page has link' do
				expect(page).to have_link @user.first_name, href: '/users/edit'
			end 

			scenario 'should be false if page has given link' do
				expect(page).to have_button 'Sign in'
			end 

			scenario 'should be true if page has no errors' do
				expect(page).to have_no_css 'div.flash.error'
			end 

			scenario 'should be false if page has errors' do
				expect(page).not_to have_css 'div.flash.error'
			end 
		end  
	end  

	context 'given sign out link' do 
		
		before { visit '/users/sign_in' }

		context 'with successful sign out' do 
			
			scenario 'should be true if page has link' do
				@user.sign_in
				@user.sign_out

				expect(page).to have_link 'Try It Free', href: '/users/sign_up'
			end  

			scenario 'should be false if page has link' do
				expect(page).to_not have_link 'Logout', href: '/users/sign_out'
			end 
					
			scenario 'should be true if page has no errors' do  
				expect(page).to have_no_css 'div.flash.error'
			end       

			scenario 'should be false if page has errors' do  
				expect(page).not_to have_css 'div.flash.error'
			end 
		end
	end      
end 

