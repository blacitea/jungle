require 'rails_helper'

RSpec.feature "User authentication", type: :feature, js: true do
  before :each do
    user = User.create!(first_name: 'Alice', last_name: 'House', email: 'ah@ym.com', password: 'light', password_confirmation: 'light')
  end

  scenario "can login with correct credentials" do
    visit root_path
    page.find_link('Login').click
    expect(page).to have_content(/password/i)
    fill_in 'Email', with: 'ah@ym.com'
    fill_in 'Password', with: 'light'
    #puts page.html
    page.click_button 'Login' #click_button must append a page
    #save_screenshot
    expect(page).to have_content('Signed in as Alice')
    expect(page).to have_content('Products')
  end
end
