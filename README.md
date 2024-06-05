<a name="readme-top"></a>
<div align="center">
  <a href="https://github.com/onewonderjapan/terraform-Quicksight">
    <img src="images/th.jpg" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Terraformでポリシーを使ってS3の権限を割り当てる</h3>

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

このシステムでは、JSONファイルを使用して、会社名に対応するS3バケットとポリシーを簡単に定義できます。。
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
AWS CLI: [インストール手順](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/getting-started-install.html)
<br />
手順に従ってAWS CLIをインストールします。
<br />
例）
  ```sh
C:\Users\xxx>aws configure
AWS Access Key ID [****************IHCL]:
AWS Secret Access Key [****************BSO7]:
Default region name [ap-northeast-1]:
Default output format [None]:
  ```
IAMユーザー（S3Test）のアクセスキーを設定します。＊Default output format [None]はそのままエンターキーを押しても大丈夫です
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
 手順に従ってTerraformをインストールし、バージョン確認ができればインストールは成功です。
  <br />
 上記の二つの手順を終えたらプロジェクトをクローンします。
  <br />
  VS Code: [ダウンロード](https://code.visualstudio.com/download)をインストールします。
  <br />
  ターミナルの「新しいターミナル」をクリックし、コンソール欄で「Git Bash」を選びます。
  <br />

   ```sh
  $ git clone　https://github.com/onewonderjapan/terraform-Quicksight.git
  ```
<br />
<p align="right">(<a href="#readme-top">Topへ戻り</a>)</p>

### 実施方法
このプロジェクトは既存のIAMユーザー（S3Test）を例に説明します。
<br />
S3Testの権限が不足しているので、まずadminポリシーを付与します。
<br />
**customers.jsonファイルに重複しないように会社名とバケット名を記入してください。
<br />
**IAMユーザー（S3Test）を変更する場合は、
```sh
resource "aws_iam_user_policy_attachment" "attach_s3_policy" {
  count = length(local.customers_groups)
  user       = "S3Test"
  policy_arn = aws_iam_policy.s3_policy[count.index].arn
}
 ````
 リソースのuserを自身のユーザー名に変更してください。
<br />
その後、初期化を行います。
   ```sh
  $ terraform　init
  ````
プランをチェックします。
  ```sh
  $ terraform　plan
  ````
適用します。
  ```sh
  $ terraform　apply
  ````
上記の手順でポリシーを有効化した後、S3Testのadminポリシーを外します。
<br />
新しいポリシーで指定したS3バケットをすべて管理できるようになります。

<p align="right">(<a href="#readme-top">Topへ戻り</a>)</p>

## ロードマップ
- [ ] 言語対応
    - [ ] 日本語
<p align="right">(<a href="#readme-top">Topへ戻り</a>)</p>