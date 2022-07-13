# In this file, write the R-code necessary to load your original data file
# (e.g., an SPSS, Excel, or SAS-file), and convert it to a data.frame. Then,
# use the function open_data(your_data_frame) or closed_data(your_data_frame)
# to store the data.

library(worcs)
library(openxlsx)
library(haven)
# dat <- readLines("../data/DJA_forDJA.csv")
# headers <- dat[1]
# headers <- strsplit(headers, split = ",")[[1]]
# dat <- dat[-1]
# dat <- paste0(dat, collapse = "")
# tmp <- strsplit(dat, split = "[a-z0-9\\-]{36},")[[1]]
# tmp <- tmp[!tmp == ""]
# writeLines(tmp, "tmp.csv")
# testfile <- read.csv("tmp.csv")
# names(testfile) <- headers
# write.csv(testfile, "dja.csv", row.names = FALSE)

dat <- haven::read_dta("../data/DJA_forDJA.dta")

factors <- sapply(dat, function(x){
  !is.null(names(attr(x, "label")))
})
dat[factors] <- lapply(dat[factors], function(x){
  #if(! length(names(attr(x, "label"))) == length(table(x))) browser()
  factor(x, labels = names(attr(x, "label"))[as.integer(names(table(x)))])
})
type <- sapply(dat, function(x){class(x)[1]})

openxlsx::write.xlsx(dat, "dja.xlsx")
