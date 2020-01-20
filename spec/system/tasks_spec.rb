require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let(:user) { create(:user) }
  describe 'create a task' do
    context 'valid to create a task' do
      it 'is valid to create a task by current_user' do
        login(user)
        visit new_task_path
        fill_in 'Title', with: 'テストデータ'
        click_button 'Create Task'
        expect(page).to have_content 'Task was successfully created.'
        expect(page).to have_content 'テストデータ'
        expect(Task.count).to eq 1
        expect(current_path).to eq '/tasks/1'
      end
    end

    context 'invalid to create a task' do
      it 'is invalid to create a task without login' do
        visit new_task_path
        expect(current_path).to eq login_path
        expect(page).to have_content 'Login required'
      end
    end
  end

  describe 'edit a task' do
    context 'valid to edit a task' do
      it 'is valid to edit a task by current_user' do
        login(user)
        task = create(:task, user_id: user.id)
        visit edit_task_path(task)
        fill_in 'Title', with: 'テストデータ編集'
        fill_in 'Content', with: '編集しました'
        select 'doing', from: 'Status'
        fill_in 'Deadline', with: Date.new(2020, 01, 01)
        click_button 'Update Task'
        expect(page).to have_content 'Task was successfully updated.'
        expect(page).to have_content 'テストデータ編集'
        expect(page).to have_content '編集しました'
        expect(page).to have_content 'doing'
        expect(page).to have_content '2020/1/1 0:0'
        expect(current_path).to eq task_path(task)
      end
    end

    context 'invalid to edit a task' do
      it 'is invalid to edit a task without login' do
        user
        task = create(:task,user_id: user.id)
        expect(Task.count).to eq 1
        visit edit_task_path(task)
        expect(current_path).to eq login_path
        expect(page).to have_content 'Login required'
      end
    end

    context 'logged_in another_user' do
      it 'failed to edit the task by another_user' do
        user
        task = create(:task, user_id: user.id)
        User.create(
            email: 'testsample2@gmail.com',
            password: 'password',
            password_confirmation: 'password'
        )
        another_user = User.first
        login(another_user)
        expect(current_path).to eq user_path(another_user)
        visit edit_task_path(task)
        expect(current_path).to eq root_path
        expect(page).to have_content 'Forbidden'
      end
    end
  end

  describe 'destroy a task' do
    context 'valid to destroy a task' do
      it 'is valid to destroy a task by current_user' do
        login(user)
        create(:task, user_id: user.id)
        visit user_path(user)
        click_on 'Destroy'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'Task was successfully destroyed.'
        expect(Task.count).to eq 0
      end
    end
  end
end
