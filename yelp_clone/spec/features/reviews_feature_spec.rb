require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'KFC' }

  scenario 'Allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  let!(:mcd) { Restaurant.create(name: 'McDonalds') }

  scenario 'remove gets remove when restaurant is destroyed' do
    mcd.reviews.create(thoughts: 'ok', rating: 4)
    mcdonalds = Restaurant.find_by(name: 'McDonalds')
    mcdonalds.destroy
    expect(Review.find_by(thoughts: 'ok')).to be_nil
  end
end
