require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    let(:task) { create(:task) }

    it 'is valid with a title and status' do
        expect(task).to be_valid
    end

    it 'is invalid without a title' do
        task.title = nil
        expect(task).to_not be_valid
    end

    it 'is invalid without status' do
        task.status = nil
        expect(task).to_not be_valid
    end

    it 'is invalid with a duplicate title' do
        task
        another_task = Task.new(
            title: "テストタイトル",
            status: "doing"
        )
        expect(another_task).to_not be_valid
    end

    it "is valid with a another title" do
        task
        another_task = Task.new(
            title: "テストタイトル２",
            status: 0
        )
        expect(another_task).to be_valid
    end
  end
end
