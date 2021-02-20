#' Return raw results of MeCab by data.frame

#' @param text character vector.
#' @param id_name character. a name of a sentence id column.
#' @param dic character. a path to a user dictionary.
#' @param etc character. options to mecab.
#' @return data.frame.
#'
#' @importFrom tidyr unnest
#' @importFrom purrr map quietly flatten_chr
#' @importFrom tibble enframe
#' @importFrom magrittr %>% set_colnames
#' @importFrom RMeCab RMeCabText
#'
#' @examples
#' \dontrun{
#' pos_full(text,id_name="id",dic="",etc="")
#' }
#' @export
pos_full <- function(text,id_name="id",dic="",etc=""){
  res <- text %>%
    map(function(x){
      tmp <- tempfile()
      write(x,tmp)
      func <- quietly(RMeCabText)
      res <- func(tmp,dic=dic,etc=etc)$result

      res_df <- res %>%
        flatten_chr() %>%
        matrix(ncol=10,byrow=TRUE) %>%
        as.data.frame() %>%
        set_colnames(c("surface","pos","pos1","pos2","pos3","form1","form2","base","yomi","hatsuon"))
      file.remove(tmp)

      return(res_df)
    }) %>%
    enframe(name=id_name,value="value") %>%
    unnest(value) %>%
    as.data.frame()
  return(res)
}



#' Return pos results of MeCab by data.frame
#'
#' pos() can return either surface form or base form of word and its pos information.

#' @param text character vector.
#' @param type character. either "surface" or "base".
#' @param id_name character. a name of a sentence id column.
#' @param dic character. a path to a user dictionary.
#' @param etc character. options to mecab.
#' @return data.frame.
#'
#' @importFrom tidyr unnest
#' @importFrom purrr map flatten_chr
#' @importFrom tibble enframe
#' @importFrom magrittr %>%
#' @importFrom RMeCab RMeCabC
#'
#' @examples
#' \dontrun{
#' pos(text,type="surface",id_name="id",dic="",etc="")
#' }
#' @export
pos <- function(text,type=c("surface","base"),id_name="id",dic="",etc=""){
  type <- match.arg(type)
  mypref <- switch(
    type,
    "surface"=0,
    "base"=1
  )
  res <- text %>%
    map(function(x){
      mecab_raw <- RMeCabC(x,mypref=mypref,dic=dic,etc=etc)
      mecab_vec <- flatten_chr(mecab_raw)
      mecab_df <- data.frame(word=mecab_vec,pos=names(mecab_vec))
      return(mecab_df)
    }) %>%
    enframe(name=id_name,value="value") %>%
    unnest(value) %>%
    as.data.frame()
  return(res)
}
