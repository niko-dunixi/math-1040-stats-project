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

color_frequencies <- round(100 * column_totals/ sum(column_totals), 2)
s_candy_per_bag = sd(row_totals)
# We need to round to two decimals, per instruction
s_candy_per_bag = round(s_candy_per_bag, digits = 3)

png(file="pie.png")
pie(column_totals, main = 'Pie Chart for Skittle Color', labels = color_frequencies, col=skittle_colors)
legend("topright", skittle_labels, cex = 0.8, fill = skittle_colors)

png(file='pareto.png')
pareto.chart(column_totals, main = 'Pareto Chart for Skittle Color')

png(file='boxplot-candies-per-bag.png')
boxplot(row_totals)
title('Boxplot for Skittles per Bag')

png(file='histogram-candies-per-bag.png')
hist(row_totals, main = 'Histogram for Skittles per Bag', xlab='Skittles per Bag')

dev.off()

print('')
print('Five number summary')
# min_per_bag = min(row_totals)
# max_per_bag = max(row_totals)
# sprintf('Min per bag: %f', min_per_bag)
# sprintf('Max per bag: %f', max_per_bag)
# sprintf('Range: %f', max_per_bag - min_per_bag)
# q1 = round(quantile(row_totals, 0.25), digits=1)
# q2 = round(quantile(row_totals, 0.50), digits=1)
# q3 = round(quantile(row_totals, 0.75), digits=1)
# sprintf('Quartiles: %f, %f, %f', q1, q2, q3)
sprintf('StdDev s: %f', s_candy_per_bag)
x_bar = round(total / n_bags, digits=1)
sprintf('Sample average x_bar: %f', x_bar)
print(round(summary(row_totals), digits=1))
print('')

print('Confidence interval for yellow proportion')
p_hat_yellow = round(column_totals['Yellow'] / total, digits=3)
sprintf('p_hat_yellow: %f', p_hat_yellow)
z_a2_yellow = 2.575
sprintf('z/a2_yellow: %f', z_a2_yellow)
e_yellow = z_a2_yellow * sqrt((p_hat_yellow * (1 - p_hat_yellow)) / total)
sprintf('e_yellow: %f', e_yellow)
sprintf('P Yellow Confidence: (%f, %f)', round(p_hat_yellow - e_yellow, digits=3), round(p_hat_yellow + e_yellow, digits=3))
print('')

print('Confidence interval for number of skittles per bag')
t_mean = 2.069
e_mean = t_mean * s_candy_per_bag / sqrt(n_bags)
sprintf('Error for mean interval: %f', e_mean)
sprintf('Interval xbar +- e (%f, %f)', round(x_bar - e_mean, digits=3), round(x_bar + e_mean, digits=3))
