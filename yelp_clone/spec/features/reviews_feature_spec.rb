require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'KFC' }

  scenario 'Allows users to leave a review using a form' do

    visit '/'
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')

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

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link('Review KFC')
    fill_in('Thoughts', with: thoughts)
    select rating, from: 'Rating'
    click_button('Leave Review')
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('So so', '3')
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: ★★★★☆')
  end
end
