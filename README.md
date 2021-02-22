
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mecabtools

<!-- badges: start -->

<!-- badges: end -->

Collection of useful functions that return tidy text data.frame and make
“wakatigaki” to text from RMeCab.

RMeCabによる形態素解析の結果をtidy
textなdata.frameで返す関数と、分かち書きをする関数が含まれます。RMeCabで形態素解析を行い、出力を整形しています。

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

引数は以下の通りです。

  - text: 形態素解析を行いたい文章です。ベクトルも可能です。
  - id\_name: 返り値のdata.frameの文章ID列の名前です。NULLを指定すると文章ID列を出力しません。
  - dic: MeCabのユーザー辞書のファイルパスです。
  - etc: MeCabに渡したい他のオプションです。

<!-- end list -->

``` r
mecabtools::pos_full(text,id_name="id")
#>   id        surface    pos       pos1 pos2 pos3            form1  form2
#> 1  1 吾輩は猫である   名詞   固有名詞 一般    *                *      *
#> 2  1             。   記号       句点    *    *                *      *
#> 3  2           名前   名詞       一般    *    *                *      *
#> 4  2             は   助詞     係助詞    *    *                *      *
#> 5  2           まだ   副詞 助詞類接続    *    *                *      *
#> 6  2           ない 形容詞       自立    *    * 形容詞・アウオ段 基本形
#> 7  2             。   記号       句点    *    *                *      *
#>             base                 yomi              hatsuon
#> 1 吾輩は猫である ワガハイハネコデアル ワガハイワネコデアル
#> 2             。                   。                   。
#> 3           名前               ナマエ               ナマエ
#> 4             は                   ハ                   ワ
#> 5           まだ                 マダ                 マダ
#> 6           ない                 ナイ                 ナイ
#> 7             。                   。                   。
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
#>   id           word    pos
#> 1  1 吾輩は猫である   名詞
#> 2  1             。   記号
#> 3  2           名前   名詞
#> 4  2             は   助詞
#> 5  2           まだ   副詞
#> 6  2           ない 形容詞
#> 7  2             。   記号
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
#> [1] "吾輩は猫である 。"    "名前 は まだ ない 。"
```

## 参考

[The tidy text format](https://www.tidytextmining.com/tidytext.html)
