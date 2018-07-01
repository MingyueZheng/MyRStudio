#R»æÍ¼¼ò½é
plot(pressure)
text(150,600,"presure (mm Hg)\nversus\nTemperature (Celsius)")


par(mfrow=c(2, 2), cex=0.6, mar=c(4, 4, 4, 2), mex=0.8)
plot(lm.SR <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = LifeCycleSavings),
     id.n=1, cex.caption=0.8, which=1:4,
     panel=function(...) { panel.smooth(..., col.smooth="gray") })

library(cluster)
subset <- sample(1:150, 20)
cS <- as.character(Sp <- iris$Species[subset])
cS[Sp == "setosa"] <- "S"
cS[Sp == "versicolor"] <- "V"
cS[Sp == "virginica"] <- "g"
ai <- agnes(iris[subset, 1:4])
par(mfrow=c(2, 1), cex=0.5, pty="s")
plot(ai, which=1, col=c("gray90", "gray"), labels = cS)
plot(ai, which=2, labels = cS)
