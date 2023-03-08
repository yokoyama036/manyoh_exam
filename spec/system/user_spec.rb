require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user2) }
  describe 'ユーザー登録機能' do
    context 'ユーザーを新規登録した場合' do
      it 'ユーザーページが表示される' do
        visit new_user_path
        fill_in "Name", with: "横川"
        fill_in "Email", with: "111111@gmail.com"
        fill_in "Password", with: "111111"
        fill_in "Password confirmation", with: "111111"
        click_on "Create account"
        expect(page).to have_content "横川のページ"
      end
    end
  end
  describe 'ログイン確認' do
    context 'ログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移すること' do
        visit tasks_path
        expect(page).to have_content "Log in"
      end
    end
  end
  describe 'セッション機能' do
    context 'ログインしようとした場合' do
      it 'ユーザーページが表示される' do
        visit new_session_path
        fill_in "Email", with: "123456@gmail.com"
        fill_in "Password", with: "123456"
        click_on "Log in"
        expect(page).to have_content "横山"
      end
    end
    context 'ログイン後に' do
      it '自分のマイページに飛べる' do
        visit new_session_path
        fill_in "Email", with: "123456@gmail.com"
        fill_in "Password", with: "123456"
        click_on "Log in"
        click_link "Task_Index"
        click_link "Mypage"
        expect(page).to have_content "横山"
      end
    end
    context '一般ユーザが他人の詳細画面に飛ぼうとした場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_session_path
        fill_in "Email", with: "123456@gmail.com"
        fill_in "Password", with: "123456"
        click_on "Log in"
        visit user_path(user2)
        expect(page).to have_content '権限がありません'
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログアウトしようとした場合' do
      it 'ログアウトできること' do
        visit new_session_path
        fill_in "Email", with: "123456@gmail.com"
        fill_in "Password", with: "123456"
        click_on "Log in"
        click_link "Logout"
        expect(page).to have_content 'ログアウトしました'
        expect(page).to have_content 'Log in'
      end
    end
  end
  describe '管理者機能' do
    context '管理ユーザが管理画面にアクセス使用とした場合' do
      it 'アクセスできること' do
        visit new_session_path
        fill_in "Email", with: "222222@gmail.com"
        fill_in "Password", with: "222222"
        click_on "Log in"
        click_on "管理者ページ"
        expect(page).to have_content '管理者ページ'
      end
    end
    context '一般ユーザが管理ページにアクセスしようとした場合' do
      it 'アクセスできないこと' do
        visit new_session_path
        fill_in "Email", with: "123456@gmail.com"
        fill_in "Password", with: "123456"
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end
    context '管理ページからユーザーの新規登録をしようとした場合' do
      it '登録できること' do
        visit new_session_path
        fill_in "Email", with: "222222@gmail.com"
        fill_in "Password", with: "222222"
        click_on "Log in"
        click_on "管理者ページ"
        click_on "Create New User"
        fill_in "Name", with: "横川"
        fill_in "Email", with: "111111@gmail.com"
        fill_in "Password", with: "111111"
        fill_in "Password confirmation", with: "111111"
        click_on "Create account"
        expect(page).to have_content "横川"
      end
    end
    context '管理ページからユーザーの詳細ページにアクセスした場合' do
      it 'アクセスできること' do
        visit new_session_path
        fill_in "Email", with: "222222@gmail.com"
        fill_in "Password", with: "222222"
        click_on "Log in"
        click_on "管理者ページ"
        visit admin_user_path(user)
        expect(page).to have_content "横山"
      end
    end
    context '管理者がユーザーの編集ページにアクセスした場合' do
      it 'アクセス/編集できること' do
        visit new_session_path
        fill_in "Email", with: "222222@gmail.com"
        fill_in "Password", with: "222222"
        click_on "Log in"
        click_on "管理者ページ"
        visit edit_admin_user_path(user)
        fill_in "Name", with: "横山1"
        fill_in "Email", with: "123456@gmail.com"
        click_on "Update"
        expect(page).to have_content "横山1"
      end
    end
    context '管理者がユーザーを削除しようとした場合' do
      it '削除できること' do
        visit new_session_path
        fill_in "Email", with: "222222@gmail.com"
        fill_in "Password", with: "222222"
        click_on "Log in"
        click_on "管理者ページ"
        click_link "Delete", match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content '横山'
      end
    end
  end
end