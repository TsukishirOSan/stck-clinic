require 'spec_helper'

describe 'Admin Panel', type: :feature do
  let(:admin_url) { '/admin' }
  let(:password) { FactoryGirl.build(:user).password } # HATE THIS

  describe '/admin' do
    context 'given no user' do
      it 'redirects to login' do
        visit admin_url
        expect(page).to have_content('Sign in')
      end
    end

    context 'given a logged-in user' do
      let(:user) { FactoryGirl.create(:user) }

      before(:each) do
        visit '/users/sign_in'
        fill_in 'Email', with: user.email
        fill_in 'Password', with: password
        click_on 'Sign in'
      end

      context 'given an admin user' do
        it 'shows the admin dashboard' do
          user.update!(admin: true)
          visit admin_url
          expect(page).to have_content('Site Administration')
        end
      end

      context 'given no admin user' do
        it 'redirects home' do
          user.update!(admin: false)
          visit admin_url
          expect(page).not_to have_content('Site Administration')
        end
      end
    end
  end
end
