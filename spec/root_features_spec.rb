require 'spec_helper'

RSpec.describe 'Root page', type: :feature do

  before { visit '/' }

	context 'has url' do
	
    it 'should be true if directs to the page with url' do
      expect(URI.parse(current_url).to_s).to eq 'http://pai-test.herokuapp.com/'
    end 

    it 'should be false if directs to the page with given url' do
      expect(URI.parse(current_url).to_s).to_not eq 'http://non-existent-site.com'
    end 
  end
  
  context 'has content' do

	  it 'should be true if directs to the page with content' do
      expect(page).to have_content 'Publicity.ai'
    end 	  

    it 'should be false if directs to page with given content' do
      expect(page).not_to have_content 'non-existent-content'
    end 
  end

  context 'has link for user to sign up' do 

    it 'should be true if sign up link is on the page' do
      expect(page).to have_link 'Try It Free', href: '/users/sign_up'
    end

    it 'should be false if the given sign up link is not on the page' do
      expect(page).not_to have_link 'Non existent link', href: '/users/sign_up'
    end 
  end

  context 'has link for user to sign in' do 

    it 'should be true if sign in link is on the page' do 
      expect(page).to have_link 'Log in', href: '/users/sign_in'
    end 

    it 'should be false if the given sign in link is not on the page' do
      expect(page).not_to have_link 'Non existent link', href: '/users/sign_in'
    end 
  end   
end    