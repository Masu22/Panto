# Panto  
### 実行タイミング：毎日18:00  
### 出力ファイル：links.txt  
### 出力するもの：リンク一覧を出力する。更新された差分を書き加えていく！！ 
---
---

# トークンの設定  
>**保存したトークンは、デスクトップで"pantoo token.txt"を検索してみて！！**  
## 1. Personal Access Token (PAT) を使用
- 右上の **プロフィールアイコンから** Settings を選択。
- Developer settings → Personal access tokens → Fined-grained Tokens → Generate new token をクリック。
- Pantooという名前や他のセッティングをした！(Expiration、Repository accessをPantoに限定、ActionとContent,commit statusを設定)
- トークン名、Expiration date、トークンのコードをコピーしておく！  

## 2. GitHub Secrets に PAT を設定
- **リポジトリPantoにアクセス**して、Settings → Secrets and variables → Actions に移動。
- New repository secret をクリックし、以下を設定：
- Name: Pantoo
- Value: 先ほどコピーした Personal Access Token を貼り付け。
- Save して、GitHub Actions がこのトークンを使って認証できるようにします。  

## 3. GitHub Actions ワークフローを変更
- .github/workflows/fetch_links.yml を次の２か所を追加した
>(はじめのほうの steps: の部分で)  
>**with:  
>  token: ${{ secrets.Pantoo }}**  #ここでGitHub Secretを使用
>
>(最後の部分で)  
>**env:  
>  GITHUB_TOKEN: ${{ secrets.Pantoo }}**  #トークンを環境変数に設定

