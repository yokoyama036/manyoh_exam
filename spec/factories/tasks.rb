# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    task_name { 'テスト' }
    detail { 'Factory動作確認' }
    deadline{'2023-03-03'}
    status{'着手中'}
  end
  factory :second_task, class: Task do
    task_name { 'テスト2' }
    detail { 'Factory動作確認2' }
    deadline{'2023-03-03'}
    status{'着手中'}
  end
end