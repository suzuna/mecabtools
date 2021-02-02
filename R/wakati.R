#' Make "wakatigaki" to text

#' @param text character vector.
#' @param collapse character. string to insert between each morphemes.
#' @param dic character. a path to a user dictionary.
#' @param etc character. options to mecab.
#' @return character vector.
#'
#' @importFrom stringr str_flatten
#' @importFrom purrr map_chr flatten_chr
#' @importFrom magrittr %>%
#' @importFrom RMeCab RMeCabC
#'
#' @examples
#' \dontrun{
#' wakati(text,collapse=" ",dic="",etc="")
#' }
#' @export
wakati <- function(text,collapse=" ",dic="",etc=""){
  res <- text %>%
    map_chr(function(x){
      x %>%
        RMeCabC(dic=dic,etc=etc) %>%
        flatten_chr() %>%
        str_flatten(collapse=collapse)
    })
  return(res)
}
