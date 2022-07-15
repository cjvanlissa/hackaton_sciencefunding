df <- read.csv("../data/for_caspar.csv")
df <- df[grep("^kt\\d", names(df))]
library(psych)
res <- psych::principal(df, nfactors = 10)
res

library(psychonetrics)
library(bootnet)

model <- ggm(df, vars = names(df), omega = "full")

model <- model |> runmodel()

model |> parameters()

prunedmodel <- model |> prune(alpha = 0.01, recursive = TRUE)

compare(saturated = model, pruned = prunedmodel)

model_stepup <- prunedmodel |> stepup()

compare(saturated = model, pruned = prunedmodel, stepup = model_stepup)

net <- estimateNetwork(df, default = "ggmModSelect", verbose = FALSE)

network <- 1*(net$graph != 0)
model_frombootnet <- ggm(df, vars = names(df), omega = network) |>
  runmodel()

compare(ggmModSelect = model_frombootnet, psychonetrics = model_stepup)

library("qgraph")
stepup_net <- getmatrix(model_stepup, "omega")
bootnet_net <- getmatrix(model_frombootnet, "omega")
L <- averageLayout(as.matrix(stepup_net), as.matrix(bootnet_net))
layout(t(1:2))
qgraph(stepup_net, labels = names(df), theme = "colorblind",
       title = "Psychonetrics estimation", layout = L)
qgraph(bootnet_net, labels = names(df), theme = "colorblind",
       title = "ggmModSelect estimation", layout = L)
