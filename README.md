**テーブルスキーマ**

| Task      |        |
| --------- | ------ |
| Colum     | Type   |
| task_name | string |
| detail    | string |

**Herokuへのデプロイ方法**
-ローカルリポジトリにアプリケーションをコミットする
-Herokuにログイン(ターミナル/webのどちらでも可)する
-Herokuで新しいアプリを作成する
-master branch以外にいるときはgit push heroku <現在いるブランチ名>:masterでデプロイする
