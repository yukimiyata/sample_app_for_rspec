require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let(:user) { create(:user) }
  describe 'login' do
    context 'input correct value in the form' do
      it 'is valid to login' do
        user
        visit login_path
        fill_in 'Email', with: 'testsample1@example.com'
        fill_in 'Password', with: 'password'
        click_button 'Login'
        expect(page).to have_content 'Login successful'
        expect(current_path).to eq root_path
      end
    end

    context 'input invalid value in the form' do
      it 'is invalid to login without value' do
        visit login_url
        click_button 'Login'
        expect(page).to have_content 'Login failed'
        expect(current_path).to eq login_path
      end
    end
  end
end
