require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let(:user) { create(:user) }
  describe 'login' do
    context ' success' do
      it 'is valid to login' do
        user
        visit login_path
        fill_in 'Email', with: 'testsample@example.com'
        fill_in 'Password', with: 'password'
        click_button 'Login'
        expect(page).to have_content 'Login successful'
        expect(current_path).to eq root_path
      end
    end

    context 'fail' do
      it 'is invalid to login without value' do
        visit login_url
        click_button 'Login'
        expect(page).to have_content 'Login failed'
      end
    end
  end
end
