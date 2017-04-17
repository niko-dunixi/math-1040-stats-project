#!/usr/bin/env rscript

library(qcc)

skittles = read.csv("skittle-data.csv", header = TRUE)
column_totals = colSums(skittles)
row_totals = rowSums(skittles)
total = sum(row_totals)

print("Column Totals")
print(column_totals)

n_bags = length(row_totals)
sprintf('Row Totals (%d bags)', n_bags)
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

print('Confidence interval for yellow proportion')
p_hat_yellow = column_totals['Yellow'] / total
sprintf('p_hat_yellow: %f', p_hat_yellow)
z_a2_yellow = 2.575
sprintf('z/a2_yellow: %f', z_a2_yellow)
e_yellow = z_a2_yellow * sqrt((p_hat_yellow * (1 - p_hat_yellow)) / total)
sprintf('e_yellow: %f', e_yellow)
sprintf('P Yellow Confidence: (%f, %f)', p_hat_yellow - e_yellow, p_hat_yellow + e_yellow)
print('')

print('Confidence interval for number of skittles per bag')
s_candy_per_bag = sd(row_totals)
sprintf('StdDev s: %f', s_candy_per_bag)
x_bar = total / n_bags
sprintf('Sample average x_bar: %f', x_bar)
t_mean = 1.714
e_mean = t_mean * s_candy_per_bag / sqrt(n_bags)
sprintf('Error for mean interval: %f', e_mean)
