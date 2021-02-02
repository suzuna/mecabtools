
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mecabtools

<!-- badges: start -->

<!-- badges: end -->

Tools of useful functions that return tidy text data.frame and make
“wakatigaki” to a text from RMeCab.

RMeCabによる形態素解析の結果をtidy textなdata.frameで返す関数と、分かち書きをする関数が含まれます。

## インストール

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

id\_nameは、文章のIDの列名です。

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

pos\_fullのうち、表層形と品詞のみを返します。

``` r
mecabtools::pos(text,id_name="id")
#>    id surface    pos
#> 1   1    吾輩   名詞
#> 2   1      は   助詞
#> 3   1      猫   名詞
#> 4   1      で 助動詞
#> 5   1    ある 助動詞
#> 6   1      。   記号
#> 7   2    名前   名詞
#> 8   2      は   助詞
#> 9   2    まだ   副詞
#> 10  2    ない 形容詞
#> 11  2      。   記号
```

### wakati

分かち書きをします。collapseで与えた文字列を挿入します。

``` r
mecabtools::wakati(text,collapse=" ")
#> [1] "吾輩 は 猫 で ある 。" "名前 は まだ ない 。"
```

## 参考

[The tidy text format](https://www.tidytextmining.com/tidytext.html)
