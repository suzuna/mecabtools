
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mecabtools

<!-- badges: start -->

<!-- badges: end -->

Collection of useful functions that return tidy text data.frame and make
“wakatigaki” to text from RMeCab.

RMeCabによる形態素解析の結果をtidy
textなdata.frameで返す関数と、分かち書きをする関数が含まれます。RMeCabで形態素解析を行い、出力を整形しています。

## インストール

MeCabとRMeCabのインストールも別途必要です。

``` r
remotes::install_github("suzuna/mecabtools")
```

## 使用例

例として、以下の文章を形態素解析します。

``` r
text <- c("吾輩は猫である。","名前はまだない。")
```

### pos\_full

MeCabの全ての出力結果（表層形、品詞、品詞細分類1、品詞細分類2、品詞細分類3、活用形1、活用形2、原形、読み、発音）をdata.frameで返します。

引数は以下の通りです。

  - text: 形態素解析を行いたい文章です。ベクトルも可能です。
  - id\_name: 返り値のdata.frameの文章ID列の名前です。NULLを指定すると文章ID列を出力しません。
  - dic: MeCabのユーザー辞書のファイルパスです。
  - etc: MeCabに渡したい他のオプションです。

<!-- end list -->

``` r
mecabtools::pos_full(text,id_name="id")
#>    id surface    pos       pos1 pos2 pos3            form1  form2 base     yomi
#> 1   1    吾輩   名詞     代名詞 一般    *                *      * 吾輩 ワガハイ
#> 2   1      は   助詞     係助詞    *    *                *      *   は       ハ
#> 3   1      猫   名詞       一般    *    *                *      *   猫     ネコ
#> 4   1      で 助動詞          *    *    *         特殊・ダ 連用形   だ       デ
#> 5   1    ある 助動詞          *    *    *   五段・ラ行アル 基本形 ある     アル
#> 6   1      。   記号       句点    *    *                *      *   。       。
#> 7   2    名前   名詞       一般    *    *                *      * 名前   ナマエ
#> 8   2      は   助詞     係助詞    *    *                *      *   は       ハ
#> 9   2    まだ   副詞 助詞類接続    *    *                *      * まだ     マダ
#> 10  2    ない 形容詞       自立    *    * 形容詞・アウオ段 基本形 ない     ナイ
#> 11  2      。   記号       句点    *    *                *      *   。       。
#>     hatsuon
#> 1  ワガハイ
#> 2        ワ
#> 3      ネコ
#> 4        デ
#> 5      アル
#> 6        。
#> 7    ナマエ
#> 8        ワ
#> 9      マダ
#> 10     ナイ
#> 11       。
```

### pos

pos\_fullのうち、表層形か原形のどちらかと、その品詞のみを返します。

引数は以下の通りです。

  - text: 形態素解析を行いたい文章です。ベクトルも可能です。
  - type: “surface”の場合は表層形、“base”の場合は原形を、返り値のdata.frameのword列に出力します。
  - id\_name: 返り値のdata.frameの文章ID列の名前です。NULLを指定すると文章ID列を出力しません。
  - dic: MeCabのユーザー辞書のファイルパスです。
  - etc: MeCabに渡したい他のオプションです。

<!-- end list -->

``` r
mecabtools::pos(text,type="surface",id_name="id")
#>    id word    pos
#> 1   1 吾輩   名詞
#> 2   1   は   助詞
#> 3   1   猫   名詞
#> 4   1   で 助動詞
#> 5   1 ある 助動詞
#> 6   1   。   記号
#> 7   2 名前   名詞
#> 8   2   は   助詞
#> 9   2 まだ   副詞
#> 10  2 ない 形容詞
#> 11  2   。   記号
```

### wakati

分かち書きをします。

引数は以下の通りです。

  - text: 形態素解析を行いたい文章です。ベクトルも可能です。
  - collapse: 分かち書きの際に挿入する文字列です。
  - dic: MeCabのユーザー辞書のファイルパスです。
  - etc: MeCabに渡したい他のオプションです。

<!-- end list -->

``` r
mecabtools::wakati(text,collapse=" ")
#> [1] "吾輩 は 猫 で ある 。" "名前 は まだ ない 。"
```

## 参考

[The tidy text format](https://www.tidytextmining.com/tidytext.html)
