#!/usr/bin/env rscript

library(qcc)

skittles = read.csv("skittle-data.csv", header = TRUE)
column_totals = colSums(skittles)
row_totals = rowSums(skittles)
total = sum(row_totals)

print("Column Totals")
print(column_totals)

print("Row Totals (individual bags)")
print(row_totals)

print('Total skittles')
print(total)

# Not suitable for labels, due to lowercasing
skittle_colors = c('red', 'orange', 'yellow', 'green', 'purple')
skittle_labels = c('Red','Orange','Yellow','Green','Purple')

color_frequencies <- round(100 * column_totals/ sum(column_totals), 1)

png(file="pie.png")
pie(column_totals, main = 'Pie Chart for Skittle Color', labels = color_frequencies, col=skittle_colors)
legend("topright", skittle_labels, cex = 0.8, fill = skittle_colors)
dev.off()

png(file='pareto.png')
pareto.chart(column_totals, main = 'Pareto Chart for Skittle Color')
dev.off()
