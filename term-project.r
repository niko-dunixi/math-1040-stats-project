#!/usr/bin/env rscript

library(qcc)

skittles = read.csv("skittle-data.csv", header = TRUE)
columnTotals = colSums(skittles)
rowTotals = rowSums(skittles)
total = sum(rowTotals)

print("Column Totals")
print(columnTotals)

print("Row Totals (individual bags)")
print(rowTotals)

print('Total skittles')
print(total)

# Not suitable for labels, due to lowercasing
skittle_colors = c('red', 'orange', 'yellow', 'green', 'purple')

piePercentages <- round(100 * columnTotals/ sum(columnTotals), 1)

png(file="pie.png")
pie(columnTotals, labels = piePercentages, col=skittle_colors)
legend("topright", c('Red','Orange','Yellow','Green','Purple'), cex = 0.8, fill = skittle_colors)
dev.off()
