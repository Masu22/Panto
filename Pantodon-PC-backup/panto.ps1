#cmdで「cd ./Pantodon」「./panto.ps1」実行している。

#日付操作：https://qiita.com/ryosuke0825/items/06eae2e99f587b5275aa
#重複削除：https://step-learn.com/article/powershell/047-array-unique.html

#更新日時を設定したけど、使わないかも
$date=Get-Date -Format "yyyy-MM-dd"

#更新情報を蓄積したリストの読み込み
$up=get-content C:\Users\NARUTO\Pantodon\Pantodon-Up.txt
#↑パスで指定しないと、フォルダ外から実行したときにエラーになると思われる！
#なので、$up=get-content ./Pantodon/Pantodon-Up.txt など

#バックアップの作成
$up >>back-up-$date.txt

#現在のHPデータを読み込み
$url=Invoke-Webrequest "http://pantodon.jp/index.rb?body=about"
$A=$url.Links.href

#データを結合して、文字列の重複を削除
$G=$up+$A|Select-Object -Unique

#ファイルに書き出し
$G >Pantodon-Up.txt