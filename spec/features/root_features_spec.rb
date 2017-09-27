require_relative '../spec_helper'

RSpec.describe 'Going to the root page', type: :feature do

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