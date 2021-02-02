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



#' Return surface and pos results of MeCab by data.frame

#' @param text character vector.
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
#' pos(text,id_name="id",dic="",etc="")
#' }
#' @export
pos <- function(text,id_name="id",dic="",etc=""){
  res <- text %>%
    map(function(x){
      mecab_raw <- RMeCabC(x,mypref=0,dic=dic,etc=etc)
      mecab_vec <- flatten_chr(mecab_raw)
      mecab_df <- data.frame(surface=mecab_vec,pos=names(mecab_vec))
      return(mecab_df)
    }) %>%
    enframe(name=id_name,value="value") %>%
    unnest(value) %>%
    as.data.frame()
  return(res)
}
