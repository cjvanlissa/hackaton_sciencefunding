# In this file, write the R-code necessary to load your original data file
# (e.g., an SPSS, Excel, or SAS-file), and convert it to a data.frame. Then,
# use the function open_data(your_data_frame) or closed_data(your_data_frame)
# to store the data.

library(worcs)
library(openxlsx)
library(haven)

# # Parse text, no longer necessary
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

# Read STATA
dat <- haven::read_dta("../data/DJA_forDJA.dta")
# Rename
# namz <- openxlsx::read.xlsx("../data/Variabelen_DJA_shortlabels.xlsx")
# write.csv(namz, "../data/Variabelen_DJA_shortlabels.csv", row.names = F)
namz <- read.csv("../data/Variabelen_DJA_shortlabels.csv")

names(dat)[match(namz$Variabele.naam, names(dat))] <- namz$short


factors <- sapply(dat, function(x){
  !is.null(names(attr(x, "label")))
})
dat[factors] <- lapply(dat[factors], function(x){
  #if(! length(names(attr(x, "label"))) == length(table(x))) browser()
  factor(x, labels = names(attr(x, "label"))[as.integer(names(table(x)))])
})
type <- sapply(dat, function(x){class(x)[1]})

secretfactor <- sapply(dat, function(x){length(table(x))}) < 23 & type == "character"
tmp <- dat[, secretfactor]
dat$language <- factor(dat$language)
dat$work_life[dat$work_life %in% c("Ja, in grote mate", "Yes, to a big degree")] <- 0
dat$work_life[dat$work_life %in% c( "Yes, to a small degree", "Ja, in kleine mate")] <- 1
dat$work_life[dat$work_life %in% c("Nee", "No")] <- 3
dat$work_life[dat$work_life %in% c("Wil / kan ik niet zeggen", "I don't want to say","")] <- NA
dat$work_life <- as.integer(dat$work_life)
type <- sapply(dat, function(x){class(x)[1]})
dat <- dat[, !type == "character"]

write.csv(dat, "../data/dat_cj.csv", row.names = F)
dat <- read.csv("../data/dat_cj.csv", stringsAsFactors = TRUE)
