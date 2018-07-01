library(ggplot2)

#以下部分观点来自本人和书籍，不准确望指正！
set.seed(1410)
dsmall <- diamonds[sample(nrow(diamonds),100),]

qplot(carat,price,data = diamonds)
qplot(log(carat),log(price),data = diamonds)

qplot(carat, x * y * z, data = diamonds)

##可以用来分类
qplot(carat, price, data = dsmall, colour = color)
qplot(carat, price, data = dsmall, shape = cut)

qplot(carat, price, data = dsmall, colour = color, shape = cut)

##可以用来重叠数据的检测，或者用来寻找分布！
#1/20 表示经过20次重叠使得不透明
qplot(carat,price,data = diamonds, alpha = I(1/10))
qplot(carat,price,data = diamonds, alpha = I(1/100))
qplot(carat,price,data = diamonds, alpha = I(1/200))

qplot(carat,price,data = dsmall, geom = c("point", "smooth"))
qplot(carat,price,data = diamonds, geom = c("point", "smooth"))

#method = "loess"  平滑器 查阅帮助？loess   
#span 控制的是平滑程度，从0(很不平滑)到1(平滑)
qplot(carat,price,data = dsmall, geom = c("point", "smooth"), span = 0.2)
qplot(carat,price,data = diamonds, geom = c("point", "smooth"), span = 1)

#Loss 内存消耗的是O(n2)，当数据大于1000的时候，默认采用gam平滑算法

library(mgcv)
qplot(carat,price,data = dsmall, geom = c("point", "smooth"), method = 'gam', formula = y ~ s(x))
#大数据时候，使用此公式formula = y ~ s(x, bs = 'cs')
qplot(carat,price,data = dsmall, geom = c("point", "smooth"), method = 'gam',formula = y ~ s(x, bs = 'cs'))

# method = 'lm' 默认拟合一条直线， 通过formula = poly(x,2)  来拟合二次多项式，
# 或者加载splines 使用自然样条 ：formula = y ~ ns(x,2),第二个是自由度，自由度越大，曲线的波动越大

library(splines)
qplot(carat,price,data = dsmall, geom = c("point", "smooth"), method = 'lm')
qplot(carat,price,data = dsmall, geom = c("point", "smooth"), method = 'lm', formula = y ~ ns(x, 5))

##ps method ='rlm' 与lm 类似，对异常值不敏感，这个在MASS包中。

qplot(color, price / carat, data = diamonds, geom = 'jitter', alpha = I(1/5))
qplot(color, price / carat, data = diamonds, geom = 'jitter', alpha = I(1/50))
qplot(color, price / carat, data = diamonds, geom = 'jitter', alpha = I(1/200))

qplot(color, price / carat, data = diamonds, geom = 'boxplot', alpha = I(1/5))
qplot(color, price / carat, data = diamonds, geom = 'boxplot', alpha = I(1/50))
qplot(color, price / carat, data = diamonds, geom = 'boxplot', alpha = I(1/200))

##直方图和密度曲线图
#binwidth 组间距 间距越大，总体特征越明显，组间距小，细节更加具体
qplot(carat, data = diamonds, geom = 'histogram', binwidth = 1, xlim = c(0,3))
qplot(carat, data = diamonds, geom = 'histogram', binwidth = 0.1, xlim = c(0,3))
qplot(carat, data = diamonds, geom = 'histogram', binwidth = 0.01, xlim = c(0,3))

qplot(carat, data = diamonds, geom = 'density', color = color)
qplot(carat, data = diamonds, geom = 'histogram', fill = color)

#条形图
qplot(color, data = diamonds, geom = 'bar')
qplot(color, data = diamonds, geom = 'bar', weight = carat) + scale_y_continuous('carat')

#时间序列中的线条图和路径图
qplot(date, unemploy / pop, data = economics, geom = 'line')
qplot(date, uempmed, data = economics, geom = 'line')

year <- function(x) as.POSIXlt(x)$year + 1900
qplot(unemploy / pop, uempmed, data = economics, geom = c('point','path'))
qplot(unemploy / pop, uempmed, data = economics, geom = 'path', colour = year(date))

#频数映射到y轴
qplot(carat, data = diamonds, facets = color ~ ., geom = 'histogram', binwidth = 0.1, xlim = c(0, 3))
#密度映射到y轴
qplot(carat, ..density.., data = diamonds, facets = color ~ ., geom = 'histogram', binwidth = 0.1, xlim = c(0, 3))

qplot(carat, price, data = dsmall, xlab = 'Price ($)', ylab = 'Weight(carats)', main = 'Price-weight relationship')
qplot(carat, price / carat, data = dsmall, xlab = 'Weight(carats)', ylab = expression(frac(price, carat)), 
      main = 'Small diamonds', xlim = c(.2, 1))
qplot(carat, price, data = dsmall, log = 'xy')