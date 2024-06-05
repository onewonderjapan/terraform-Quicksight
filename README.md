<a name="readme-top"></a>
<div align="center">
  <a href="https://github.com/onewonderjapan/terraform-Quicksight">
    <img src="images/th.jpg" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">terraformでポリシーでs3の権限を割り当てる</h3>

  <p align="center">
  </p>
</div>
<details>
  <summary>目次</summary>
  <ol>
    <li>
      <a href="#プロジェクトについて">プロジェクトについて</a>
      <ul>
        <li><a href="#言語">言語</a></li>
      </ul>
    </li>
    <li>
      <a href="#開始方法">開始方法</a>
      <ul>
        <li><a href="#インストール">インストール</a></li>
        <li><a href="#実施方法">実施方法</a></li>
      </ul>
    </li>
    <li><a href="#ロードマップ">ロードマップ</a></li>
  </ol>
</details>

## プロジェクトについて
<br />

このシステムでは、JSONファイルを使用して会社名対応S3バケットとポリシーを簡単に定義できる。
<br />
例）各ポリシーに、10customerに対してs3の権限を割り当てる。
<p align="right">(<a href="#readme-top">Topへ戻り</a>)</p>

### 言語
<br />

* <a href="https://www.terraform.io/">
    <img src="https://img.shields.io/badge/Terraform-0769AD?style=for-the-badge&logo=Terraform&logoColor=white" alt="Logo" width="80" height="20">
  </a>

<p align="right">(<a href="#readme-top">Topへ戻り</a>)</p>

## 開始方法
### インストール
aws cli:https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/getting-started-install.html
<br />
手順書によってaws cliをインストールする
<br />
例）
  ```sh
C:\Users\xxx>aws configure
AWS Access Key ID [****************IHCL]:
AWS Secret Access Key [****************BSO7]:
Default region name [ap-northeast-1]:
Default output format [None]:
  ```
IAMユーザー(S3Test)のアクセスキーを設定します。＊Default output format [None]:がそのままをエンターキーしても大丈夫です。
<br />
Terrafrom:https://developer.hashicorp.com/terraform/install?product_intent=terraform
<br />
 例）Terrafrom
  ```sh
  C:\Users\xxx>terraform version
   Terraform v1.8.2
    on windows_amd64
  ```
  <br />
  手順書によってTerrafromをインストールしてTerrafromのバージョンがあったらインストールで成功でした。
  <br />
  上記の二つ手順を終わったらプロジェクトをクーロンする
  <br />
  vscode :https://code.visualstudio.com/downloadをインストールする
  <br />
  ターミナルの新しいターミナルをクリックしてコンソール欄でGit Bashを選ぶ
  <br />

   ```sh
  $ git clone　https://github.com/onewonderjapan/terraform-Quicksight.git
  ```
<br />
<p align="right">(<a href="#readme-top">Topへ戻り</a>)</p>

### 実施方法
今プロジェクトが既存ありIAMユーザー(S3Test)を例にとして説明する
<br />
S3Testが権限足りないのでまずadminポリシに付けます。
<br />
**customers.jsonファイルの中に重複しないように会社名とバケット名が好きにしてください。
<br />
**IAMユーザー(S3Test)を代わる場合は
```sh
resource "aws_iam_user_policy_attachment" "attach_s3_policy" {
  count = length(local.customers_groups)
  user       = "S3Test"
  policy_arn = aws_iam_policy.s3_policy[count.index].arn
}
 ````
 リソースのuserが自分ユーザー名をあってください。
<br />
後で  初期化
   ```sh
  $ terraform　init
  ````
プランチェック
  ```sh
  $ terraform　plan
  ````
実施する
  ```sh
  $ terraform　apply
  ````
上記の手順でポリシ有効化にしてからS3Testのadminポリシを外れ。
<br />
最後新しいポリシーで添付したS3バケットを全部管理できるようになる。

<p align="right">(<a href="#readme-top">Topへ戻り</a>)</p>

## ロードマップ
- [ ] 言語対応
    - [ ] 日本語
<p align="right">(<a href="#readme-top">Topへ戻り</a>)</p>