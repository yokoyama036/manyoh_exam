require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  describe '新規作成機能' do
    let!(:user) { FactoryBot.create(:user) }
    context '新規登録画面でラベル情報を登録した場合' do
      it '登録可能なこと' do
        visit new_session_path
        fill_in "Email", with: '123456@gmail.com'
        fill_in "Password", with: '123456'
        click_on "Log in"
        click_on "Task_Index"
        click_button '新規登録'
        fill_in "task[task_name]", with: "万葉課題"
        fill_in "task[detail]", with: "step5"
        fill_in "task[deadline]", with: "2023-03-10"
        select '着手中', from: 'task[status]'
        fill_in 'task[labels_attributes][0][label_name]', with: 'test'
        click_button '登録する'
        expect(page).to have_content 'test'
      end
    end
    context '1つのタスクにラベル情報を登録する場合' do
      it '複数登録可能なこと' do
        visit new_session_path
        fill_in "Email", with: '123456@gmail.com'
        fill_in "Password", with: '123456'
        click_on "Log in"
        click_on "Task_Index"
        click_button '新規登録'
        fill_in "task[task_name]", with: "万葉課題"
        fill_in "task[detail]", with: "step5"
        fill_in "task[deadline]", with: "2023-03-10"
        select '着手中', from: 'task[status]'
        fill_in 'task[labels_attributes][0][label_name]', with: 'test'
        click_button '登録する'
        click_on '編集', match: :first
        fill_in 'task[labels_attributes][1][label_name]', with: 'test2'
        click_button '更新する'
        expect(page).to have_content 'test'
        expect(page).to have_content 'test2'
      end
    end
    context 'ラベル情報を登録した場合' do
      it '詳細画面からラベル情報が確認できること' do
        visit new_session_path
        fill_in "Email", with: '123456@gmail.com'
        fill_in "Password", with: '123456'
        click_on "Log in"
        click_on "Task_Index"
        click_button '新規登録'
        fill_in "task[task_name]", with: "万葉課題"
        fill_in "task[detail]", with: "step5"
        fill_in "task[deadline]", with: "2023-03-10"
        select '着手中', from: 'task[status]'
        fill_in 'task[labels_attributes][0][label_name]', with: 'test1'
        click_button '登録する'
        click_on '詳細', match: :first
        expect(page).to have_content 'test1'
      end
    end
    context 'ラベル情報を登録した場合' do
      it 'ラベルで検索が可能なこと' do
        visit new_session_path
        fill_in "Email", with: '123456@gmail.com'
        fill_in "Password", with: '123456'
        click_on "Log in"
        click_on "Task_Index"
        click_button '新規登録'
        fill_in "task[task_name]", with: "万葉課題"
        fill_in "task[detail]", with: "step5"
        fill_in "task[deadline]", with: "2023-03-10"
        select '着手中', from: 'task[status]'
        fill_in 'task[labels_attributes][0][label_name]', with: 'テスト'
        click_button '登録する'
        click_button '新規登録'
        fill_in "task[task_name]", with: "万葉課題1"
        fill_in "task[detail]", with: "step5"
        fill_in "task[deadline]", with: "2023-03-10"
        select '着手中', from: 'task[status]'
        fill_in 'task[labels_attributes][0][label_name]', with: 'test1'
        click_button '登録する'
        fill_in 'task[label_search]', with: 'test1'
        click_on '検索'
        expect(page).to have_content 'test1'
        expect(page).not_to have_content 'テスト'
      end
    end
  end
end