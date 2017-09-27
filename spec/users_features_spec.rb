require 'spec_helper'
require 'user'

# Capybara::Session.new :selenium_chrome

RSpec.describe User, type: :feature do

  before(:all) { @user = User.new } 

	describe 'sign up' do

		before { visit '/users/sign_up' }
		
    it 'should be true if directs to page with url' do
      expect(URI.parse(current_url).to_s).to eq('http://pai-test.herokuapp.com/users/sign_up')
    end 

    it 'should be false if directs to page with given url' do
      expect(URI.parse(current_url).to_s).to_not eq('http://non-existent-site.com')
    end 
 
	  context 'has content' do

		  it 'should be true if page has content' do
	      expect(page).to have_content('Try Publicity.ai free')
	    end 	  

	    it 'should be false if page has given content' do
	      expect(page).not_to have_content('non-existent-content')
	    end 
	  end

	  context 'has button' do

	    it 'should be true if sign up button to submit form is on page' do
	      expect(page).to have_button('Start Analyzing »')
	    end

	    it "should be false if the given button is not on page" do
	      expect(page).not_to have_button('non-existent-button')
	    end 
	  end  

	  context 'has form' do
	    
	    it 'should be true if form to sign up is on page' do
	      expect(page).to have_css('form#new_user')
	    end   

	    it 'should be false if the given form to sign up is not on page' do
	      expect(page).not_to have_css('form.non-existent-form')
	    end  
    end
    
	  context 'allows a new user to sign up' do 
	    
	    it 'should be true if page has content' do
        @user.sign_up

        expect(page).to have_content('Welcome! You have signed up successfully.')
        expect(page).not_to have_link('Try It Free', href: '/users/sign_up')
        expect(page).to have_link('Logout', href: '/users/sign_out')
        expect(page).to have_no_css 'div.flash.error'	
      end  

		  it 'should be false if given input is valid' do
        @user.sign_up
	      	
        expect(page).to have_css 'div.alert-danger'	
		  end  
    end
	end

  describe 'sign in' do
		
		before { visit '/users/sign_in' }

    it 'should be true if directs to page with url' do
      expect(URI.parse(current_url).to_s).to eq('http://pai-test.herokuapp.com/users/sign_in')
    end 

    it 'should be false if directs to page with given url' do
      expect(URI.parse(current_url).to_s).to_not eq('http://non-existent-site.com')
    end 
 
	  context 'has content' do

		  it 'should be true if page has content' do
	      expect(page).to have_content('Log in')
	    end 	  

	    it 'should be false if page has given content' do
	      expect(page).not_to have_content('non-existent-content')
	    end 
	  end

	  context 'has button' do

	    it 'should be true if sign in button to submit form is on page' do
	      expect(page).to have_button('Sign in')
	    end

	    it "should be false if the given button is not on page" do
	      expect(page).not_to have_button('non-existent-button')
	    end 
	  end  

	  context 'has form' do
	    
	    it 'should be true if form to sign in is on page' do
	      expect(page).to have_css('form#new_user')
	    end   

	    it 'should be false if the given form to sign in is not on page' do
	      expect(page).not_to have_css('form.non-existent-form')
	    end  
    end 
    
	  context 'allows an existing user to sign in' do 
	    
	    it 'should be true if page has content' do
        @user.sign_in

        expect(page).to have_content 'Signed in successfully.'
      end 

      it 'should be false if page has given content' do
        expect(page).not_to have_content 'Not signed in successfully.'
      end	

      it 'should be true if page has link' do
      	name = @user.class
      	p name
      	p @user
        expect(page).to have_link(@user.first_name, href: '/users/edit')
      end 

      it 'should be false if page has given link' do
        expect(page).to have_button('Sign in')
      end	

      it 'should be true if page has no errors' do
      	expect(page).to have_no_css 'div.flash.error'
      end	

      it 'should be false if page has errors' do
      	expect(page).not_to have_css 'div.flash.error'
      end	
    end  
  end  

  describe 'sign out' do 
  	
  	before { visit '/users/sign_in' }

    context 'allows an existing user to sign out' do 
	    
	    it 'should be true if page has link' do
	    	@user.sign_in
	    	@user.sign_out

	      expect(page).to have_link('Try It Free', href: '/users/sign_up')
	    end  

	    it 'should be false if page has link' do
        expect(page).to_not have_link('Logout', href: "/users/sign_out")
	    end 
	        
	    it 'should be true if page has no errors' do  
	      expect(page).to have_no_css 'div.flash.error'
	    end 	    

	    it 'should be false if page has errors' do  
	      expect(page).not_to have_css 'div.flash.error'
	    end 
	  end
	end      
end  
