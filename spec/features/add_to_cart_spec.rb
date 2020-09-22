require 'rails_helper'

RSpec.feature "Visitor add product to cart", type: :feature, js: true do

  # SETUP

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "My cart count increase one with Add button clicked" do
    # ACT
    visit root_path
    product = page.find('article.product', match: :first)
    expect(page).to have_content 'My Cart (0)'
    product.find_button('Add').click
    expect(page).to have_content 'My Cart (1)'
    # DEBUG / VERIFY
    save_screenshot

  end
end