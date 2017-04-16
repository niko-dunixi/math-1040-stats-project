#!/usr/bin/env rscript

skittles = read.csv("skittle-data.csv", header = TRUE)
columnTotals = colSums(skittles, na.rm=FALSE, dims = 1)
rowTotals = rowSums(skittles, na.rm=FALSE, dims = 1)

# Not suitable for labels, due to lowercasing 
skittle_colors = c('red', 'orange', 'yellow', 'green', 'purple')


print("Column Totals")
print(columnTotals)

print("Row Totals")
print(rowTotals)

piePercentages <- round(100 * columnTotals/ sum(columnTotals), 1)

png(file="pie.png")
pie(columnTotals, labels = piePercentages, col=rainbow(length(columnTotals)))
legend("topright", c('Red','Orange','Yellow','Green','Purple'), cex = 0.8, fill = rainbow(length(columnTotals)))
#pie(columnTotals)
dev.off()
