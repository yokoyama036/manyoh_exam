**テーブルスキーマ**

| Task      |        |
| --------- | ------ |
| Colum     | Type   |
| task_name | string |
| detail    | string |

**Herokuへのデプロイ方法**
-ローカルリポジトリにアプリケーションをコミットする
-Herokuにログインする
-Heroku createで新しいアプリを作成する
-master branch以外にいるときはgit push heroku <現在いるブランチ名>:masterでデプロイする
