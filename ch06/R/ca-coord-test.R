# Test cacoord()
haireye <- margin.table(HairEyeColor, 1:2)
haireye.ca <- ca(haireye)
res <- plot(haireye.ca)
res

# shouldn't these be the same as returned by plot.ca()
coords <- cacoord(haireye.ca, type="symmetric")
coords

# constant scaling factor for each dimension
res$rows / coords$rows[, 1:2]
res$cols / coords$columns[, 1:2]
