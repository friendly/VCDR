# calculate bivariate logits and OR
blogits <- function(Y, add, colnames, row.vars, rev=FALSE) {

  if (ncol(Y) != 4) stop("Y must have 4 columns")
  if (missing(add)) add <- if (any(Y==0)) 0.5 else 0
  Y <- Y + add
  if (rev) Y <- Y[,4:1]
  L <- matrix(0, nrow(Y), 3)
  L[,1] <- log( (Y[,1] + Y[,2]) / (Y[,3] + Y[,4]) )
  L[,2] <- log( (Y[,1] + Y[,3]) / (Y[,2] + Y[,4]) )
  L[,3] <- log( (Y[,1] * Y[,4]) / ((Y[,2] * Y[,3])) )
  cn <- c("logit1", "logit2", "logOR")
  colnames(L) <- if(missing(colnames)) cn else c(colnames, cn[-(1:length(colnames))])
  if(!missing(row.vars)) L <- cbind(L, row.vars)
  L
}


TESTME <- TRUE
if(TESTME) {
tox.tab <- xtabs(Freq~class + smoke + hyper + urea, Toxaemia)
toxaemia <- t(matrix(aperm(tox.tab), 4, 15))
colnames(toxaemia) <- c("hu", "hU", "Hu", "HU")
rowlabs <- expand.grid(smoke=c("0", "1-19", "20+"), class=factor(1:5))
toxaemia <- cbind(toxaemia, rowlabs)
logitsTox <- blogits(toxaemia, colnames=c("logitH", "logitW"), row.vars=rowlabs)

}
