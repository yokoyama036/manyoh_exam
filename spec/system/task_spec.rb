require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        task = Task.create(task_name: 'new', detail: 'test', deadline: '2023-03-03', status: '未着手')
        visit tasks_path
        task_list = all('.task_row')
        expect(page).to have_content '2023-03-03'
        expect(page).to have_content '未着手'
        
        # task = Task.new(task_name: 'new', detail: 'test', deadline: '2023-03-03')
        # expect(task.deadlin).to eq '2023-03-03'
        # 上記だとテストが通らない。理由を明確にしてから次へ。
      end
    end
  end
  describe '一覧表示機能' do
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

    context 'タスク終了期限でソートされた場合' do
      it '終了期限の近いものが一番上に表示される' do
        task1 = Task.create(task_name: '222', detail: '222', id: 1, deadline: Time.current + 5.days)
        task2 = Task.create(task_name: '111', detail: '111', id: 3, deadline: Time.current + 10.days)
        task3 = Task.create(task_name: '333', detail: '333', id: 2, deadline: Time.current + 1.days)

        visit tasks_path

        click_on '終了期限'
        sleep(0.5)
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '333'
        expect(task_list[1]).to have_content '222'
        expect(task_list[2]).to have_content '111'

      end
    end
    context 'タイトルで検索した場合' do
      it '該当するものが表示される' do
        task = Task.create(task_name: 'new', detail: 'test', deadline: '2023-03-03', status: '未着手')
        task = Task.create(task_name: 'old', detail: 'test', deadline: '2023-03-03', status: '未着手')
        task = Task.create(task_name: 'old', detail: 'test', deadline: '2023-03-03', status: '未着手')

        visit tasks_path
        fill_in 'task[name_search]', with: 'new'
        click_on '検索'
        sleep(0.5)
        expect(page).to have_content 'new'
        expect(page).not_to have_content 'old'
      end
    end
    context 'ステータスで検索した場合' do
      it '完全一致するものが表示される' do
        task = Task.create(task_name: 'new', detail: 'test', deadline: '2023-03-03', status: '着手中')
        task = Task.create(task_name: 'old', detail: 'test', deadline: '2023-03-03', status: '未着手')
        task = Task.create(task_name: 'old', detail: 'test', deadline: '2023-03-03', status: '未着手')

        visit tasks_path
        select '着手中', from: 'task[status]'
        click_on '検索'
        sleep(0.5)
        expect(page).to have_content 'new'
        expect(page).not_to have_content 'old'
        # expect(page).not_to eq '未着手'
        # #↑井関さんメンタリングで変更。未着手/着手中問わずtrueがかえる。
      end
    end
    context 'タイトルとステータスの両方で検索した場合' do
      it 'タイトルが部分一致、ステータスが完全一致するものが表示される' do
        task = Task.create(task_name: 'new', detail: 'test', deadline: '2023-03-03', status: '未着手')
        task = Task.create(task_name: 'old', detail: 'test', deadline: '2023-03-03', status: '未着手')
        task = Task.create(task_name: 'old', detail: 'test', deadline: '2023-03-03', status: '着手中')
        
        visit tasks_path
        fill_in 'task[name_search]', with: 'new'
        select '未着手', from: 'task[status]'
        click_on '検索'
        sleep(0.5)
        expect(page).to have_content 'test'
        expect(page).not_to have_content 'old'
      end
    end
  end
end