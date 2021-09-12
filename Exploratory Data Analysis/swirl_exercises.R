# Exploring the base plotting system.

# 1
plot(airquality$Wind, airquality$Ozone, type = "n")
title(main = "Wind and Ozone in NYC")
may <- subset(airquality, Month==5)
points(may$Wind, may$Ozone, col = "blue", pch=17)
notmay <- subset(airquality, Month != 5)
points(notmay$Wind, notmay$Ozone, col = "red", pch=8)
legend("topright", pch = c(17, 8), col = c("blue", "red"), legend = c("May", "Other Months"))
abline(v = median(airquality$Wind), lty=2, lwd=2)

# 2
par(mfrow = c(1,2))
plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
plot(airquality$Ozone, airquality$Solar.R, main = "Ozone and Solar Radiation")

# 3
# oma is connected to the mtext command. We make space for the general title on the top.
par(mfrow = c(1,3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
plot(airquality$Solar.R, airquality$Ozone, main = "Ozone and Solar Radiation")
plot(airquality$Temp, airquality$Ozone, main = "Ozone and Temperature")
mtext("Ozone and Weather in New York City", outer = TRUE)