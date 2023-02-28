require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        task = Task.new(task_name: 'new', detail: 'test')
        expect(task.detail).to eq 'test'
      end
    end
  end

    # テスト内容を追加で記載する
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task1 = Task.create(task_name: '222', detail: '222', id: 1, created_at: Time.current + 1.days)
        task2 = Task.create(task_name: '111', detail: '111', id: 3)
        task3 = Task.create(task_name: '333', detail: '333', id: 2, created_at: Time.current + 2.days)

        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '333'
        expect(task_list[1]).to have_content '222'
        expect(task_list[2]).to have_content '111'

        # expect(page.text).to match(/#{task1.task_name}[\s\S]*#{task2.task_name}/)
      end
    end
  end