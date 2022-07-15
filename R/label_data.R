write_labels <- function(x, variables = names(x)[sapply(x, inherits, what = "factor")], output = "value_labels.yml"){
  df <- x[variables]
  out <- lapply(df, function(i){
    whatclass <- class(i)[1]
    res <- levels(i)
    names(res) <- 1:length(levels(i))
    c(list(class = whatclass), as.list(res))
  })
  yaml::write_yaml(out, file = output)
}

read_labels <- function(input = "value_labels.yml"){
  labs <- yaml::read_yaml(input)
  class(labs) <- c("value_labels", class(labs))
  labs
}

data_label <- function(x, variables = names(x), value_labels = read_labels()){
  out <- x
  for(nam in variables){
    if(!nam %in% names(value_labels)){
      message("Variable '", nam, "' not found in value_labels.")
      next
    }
    switch(value_labels[[nam]][["class"]],
           "factor" = {
             out[[nam]] <- factor(x[[nam]], levels = names(value_labels[[nam]])[-1], labels = unlist(value_labels[[nam]][-1]))
           },
           "ordered" = {
             out[[nam]] <- ordered(x[[nam]], levels = names(value_labels[[nam]])[-1], labels = unlist(value_labels[[nam]][-1]))
           })
  }
  out
}
