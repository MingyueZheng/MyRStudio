library(ggplot2)


#以下部分观点来自本人和书籍，不准确望指正！
p <- qplot(displ, hwy, data = mpg, colour = factor(cyl))
summary(p)

#保存图形对象
save(p, file = 'plot.rdata')
#读入图形对象
load('plot.rdata')
#保存为png格式 
ggsave('plot.png',width =5, height = 5)

qplot(displ, hwy, data = mpg, facets = .~year) + geom_smooth()
