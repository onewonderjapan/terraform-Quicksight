<a name="readme-top"></a>
<div align="center">
  <a href="https://github.com/onewonderjapan/terraform-Quicksight">
    <img src="images/th.jpg" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">terraformでポリシーでs3の権限を割り当てる</h3>

  <p align="center">
   test
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
AWSユーザーのアクセスキーを設定します。＊Default output format [None]:がそのままをエンターキーしても大丈夫です。
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
　　$ git clone　https://github.com/onewonderjapan/　　terraform-Quicksight.git
  ```
<p align="right">(<a href="#readme-top">Topへ戻り</a>)</p>

### 実施方法


## ロードマップ
- [ ] 言語対応
    - [ ] 日本語
<p align="right">(<a href="#readme-top">Topへ戻り</a>)</p>