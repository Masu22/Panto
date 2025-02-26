#今のところ、urlは１個指定している。本来は、url一覧からurlを１つ読み込みしておく。
#本文の数式の部分は\を抜いてしまったので、修正の必要あり！！
#termに重複はあると思われる。エクセルなどにして取り除く？？

$url="https://library.fiveable.me/algebraic-geometry/unit-3/schemes-morphisms/study-guide/Qs3GNEkjD8ZjycaG"
$page=Invoke-webrequest $url

#ソースファイルを書き出し
$G=$page.content

#改行して整理
$G1=$G.split("`"")
$G2=$G1.split("\")

#タイトルの取得
$T=$G2|Where-object {$_ -like "review*"}|Sort-object -unique
"title:" >>"${T}.txt"
$T >>"${T}.txt"


#画像の取得
"pictures:" >>"${T}.txt"
$G2|Where-object {$_ -like "*storage*"}|Sort-object -unique >>"${T}.txt"


#本文の取得(markdown～cheatsheetまでが本文)
"main contents:" >>"${T}.txt"
$j=0
for($i=0; $i -lt $G2.length; $i++){
 if($G2[$i] -eq "markdown"){$j=1}

 if($j -eq 1){
  $G2[$i] >>"${T}.txt"
 }
 if($G2[$i] -eq "cheatsheet"){break}
}


#termの取得(ひとまずは重複あり、あとでエクセルにして取り除く？)
"terms:" >>"${T}.txt"
for($i=0; $i -lt $G2.length; $i++){
 if(($G2[$i] -eq "term") -Or ($G2[$i] -eq "definition")){
  $G2[$i+4] >>"${T}.txt"
 }
}

