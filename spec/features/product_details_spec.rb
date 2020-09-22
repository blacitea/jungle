require 'rails_helper'

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do

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

  scenario "By clicking details_link" do
    # ACT
    visit root_path
    expect(page).to have_css 'article.product' ,count: 10
    product = page.find('article.product', match: :first)
    product.find_link('Details').click
    expect(page).to have_content 'Description'
    # DEBUG / VERIFY
    save_screenshot

  end

  scenario "By clicking product_image" do
    # ACT
    visit root_path
    product = page.find('article.product', match: :first)
    product.find("img").click
    expect(page).to have_content 'Description'
    # DEBUG / VERIFY
    save_screenshot
    # puts page.html
    # puts product.inspect

  end

  scenario "By clicking product name" do
    # ACT
    visit root_path
    product = page.find('article.product', match: :first)
    product.find("h4").click
    expect(page).to have_content 'Description'
    # DEBUG / VERIFY
    save_screenshot

  end

end