require 'rails_helper'

RSpec.feature "FirstCapybaraTests", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Electronics'
    @category.products.create!(
      name: 'Nivida 3800',
      description: 'super fast',
      image: '',
      quantity: 1,
      price: 50000
    )
  end

  scenario "Go do home page" do
    visit '/'
    page.save_screenshot
  end
end
