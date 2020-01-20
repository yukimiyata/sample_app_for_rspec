require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }
  describe 'create a new user' do
    context 'input correct form' do
      it 'can create a new user' do
        expect(user).to be_valid
      end
    end
  end

  describe 'edit user' do
    context 'logged_in user' do
      it 'is able to edit user' do
        visit login_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        click_button 'Login'
        visit edit_user_path(user)
        fill_in 'Email', with: 'sampletest@gmail.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Update'
        expect(page).to have_content 'Email: sampletest@gmail.com'
      end
    end

    context 'logged_in another_user' do
      it 'failed to login by another_user'
      another_user = User.create(
                             email: 'testsample2@gmail.com',
                             password: 'password',
                             password_confirmation: 'password'
      )

    end
  end
end
