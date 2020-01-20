require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }
  describe 'create a new user' do
    context 'input correct value in form' do
      it 'is valid to create a new user' do
        visit sign_up_path
        fill_in 'Email', with: 'testsample@gmail.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'SignUp'
        expect(current_path).to eq login_path
        expect(page).to have_content 'User was successfully created.'
      end
    end

    context 'input missing value in form' do
      it 'is invalid without email' do
        visit sign_up_url
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'SignUp'
        expect(page).to have_content "Email can't be blank"
      end
    end

    context 'input used email in form' do
      it 'is invalid to create a user' do
        user
        visit sign_up_url
        fill_in 'Email', with: 'testsample@gmail.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'SignUp'
        expect(page).to have_content 'Email has already been taken'
      end
    end
  end

  describe 'edit user' do
    context 'logged_in correct user' do
      it 'is valid to edit user' do
        login(user)
        visit edit_user_path(user)
        fill_in 'Email', with: 'sampletest@gmail.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Update'
        expect(page).to have_content 'Email: sampletest@gmail.com'
        expect(current_path).to eq user_path(user)
        expect(page).to have_content 'User was successfully updated.'
      end
    end

    context 'logged_in another_user' do
      it 'failed to edit the user by another_user' do
        User.create(
            email: 'testsample2@gmail.com',
            password: 'password',
            password_confirmation: 'password'
        )
        another_user = User.first
        login(another_user)
        visit edit_user_path(user)
        expect(page).to have_content 'Forbidden access.'
        expect(current_path).to eq user_path(another_user)
        expect(page).to have_content 'Forbidden access.'
      end
    end

    context 'input missing value in form' do
      it 'is invalid without email' do
        login(user)
        visit edit_user_path(user)
        fill_in 'Email', with: ''
        click_button 'Update'
        expect(page).to have_content "Email can't be blank"
      end
    end
  end

  describe 'my_page' do
    context 'index task' do
      it 'can see users task in my_page' do
        login(user)
        create(:task, user_id: user.id)
        visit user_path(user)
        expect(page).to have_content 'テストタイトル'
        expect(page).to have_content 'todo'
      end
    end

    context 'without login' do
      it 'is invalid to visit my_page without login' do
        visit user_path(user)
        expect(current_path).to eq login_path
        expect(page).to have_content 'Login required'
      end
    end
  end
end




















