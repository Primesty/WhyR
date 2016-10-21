## 01-Visualization.R
# Code from 01-visualization
# install.packages("ggplot2", "hexbin")
library(ggplot2)
# library(hexbin)

plot(iris$Sepal.Width, iris$Sepal.Length)

qplot(Sepal.Width, Sepal.Length, data = iris)
qplot(Sepal.Width, Sepal.Length, data = iris, color = Species, shape = Species)
qplot(Sepal.Width, Sepal.Length, data = iris, color = Species, shape = Species) + theme_bw()
qplot(Sepal.Width, Sepal.Length, data = iris, color = Species, shape = Species, geom = c("point", "smooth"), method = lm, se = FALSE) + theme_bw()


# Diving in: Scatterplots

install.packages("ggplot2")
library(ggplot2)
?mpg
View(mpg)

qplot(displ, hwy, data = mpg)

# Aesthetics

qplot(displ, hwy, data = mpg, color = class)
qplot(displ, hwy, data = mpg, size = class)
qplot(displ, hwy, data = mpg, shape = class)
qplot(displ, hwy, data = mpg, alpha = class)

qplot(displ, hwy, data = mpg, color = class)

# Faceting

qplot(displ, hwy, data = mpg) + facet_grid(. ~ cyl)
qplot(displ, hwy, data = mpg) + facet_grid(drv ~ .)
qplot(displ, hwy, data = mpg) + facet_grid(drv ~ cyl)
qplot(displ, hwy, data = mpg) + facet_wrap(~ class)

# Geoms

qplot(displ, hwy, data = mpg, geom = "smooth")
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))

# Your Turn
# ---------------------------------------------
qplot(class, hwy, data = mpg)
qplot(class, hwy, data = mpg, geom = "boxplot")
# ---------------------------------------------

qplot(reorder(class, hwy), hwy, data = mpg, geom = "boxplot")

# Your Turn
# ---------------------------------------------
qplot(reorder(class, hwy, FUN = median), hwy, data = mpg, geom = "boxplot")
# ---------------------------------------------

# Diamonds

# Bar charts

# Your Turn
# --------------------------
qplot(x, z, data = diamonds)
qplot(x, data  = diamonds)
qplot(cut, data = diamonds)
# --------------------------

qplot(cut, data = diamonds, geom = "bar", color = cut)
qplot(cut, data = diamonds, geom = "bar", fill = cut)

# Position Adjustments

# Your Turn
# --------------------------
qplot(color, data = diamonds, geom = "bar", fill = cut)
# --------------------------

qplot(color, data = diamonds, fill = cut, position = "stack")

qplot(color, data = diamonds, fill = cut, position = "stack")
qplot(color, data = diamonds, fill = cut, position = "dodge")
qplot(color, data = diamonds, fill = cut, position = "identity")
qplot(color, data = diamonds, fill = cut, position = "fill")

qplot(cty, hwy, data = mpg)
qplot(cty, hwy, data = mpg, position = "jitter")
qplot(cty, hwy, data = mpg, geom = "jitter")

qplot(cty, hwy, data = mpg, geom = "point", position = "jitter") 
qplot(cty, hwy, data = mpg, geom = "jitter") 


# Histograms

qplot(displ, data = mpg, binwidth = 1)

qplot(carat, data = diamonds, binwidth = 1)
qplot(carat, data = diamonds, binwidth = 0.1)
qplot(carat, data = diamonds, binwidth = 0.1)
qplot(carat, data = diamonds)

zoom <- coord_cartesian(xlim = c(55, 70))
qplot(depth, data = diamonds, binwidth = 0.2) + zoom

qplot(depth, data = diamonds, binwidth = 0.2, fill = cut) + zoom

qplot(depth, data = diamonds, binwidth = 0.2) + 
  zoom + facet_wrap(~ cut)

qplot(depth, data = diamonds, geom = "freqpoly", color = cut, 
  binwidth = 0.2) + zoom + facet_wrap(~ cut)

qplot(depth, data = diamonds, geom = "freqpoly", 
  color = cut, binwidth = 0.2) + zoom

qplot(depth, data = diamonds, geom = "density", 
  color = cut) + zoom

# Your Turn
# ---------------------------------------------
qplot(price, data = diamonds, binwidth = 500) + 
  facet_wrap(~ cut)
qplot(price, data = diamonds, binwidth = 500, 
  fill = cut)
qplot(price, data = diamonds, binwidth = 500, 
  geom = "freqpoly", colour = cut)
qplot(price, data = diamonds, geom = "density", 
  colour = cut)
# ---------------------------------------------

qplot(carat, price, data = diamonds, color = cut)

# Geoms for big data

qplot(carat, price, data = diamonds)
qplot(carat, price, data = diamonds, geom = "bin2d")
qplot(carat, price, data = diamonds, geom = "hex")
qplot(carat, price, data = diamonds, geom = "density2d")
qplot(carat, price, data = diamonds, 
  geom = c("point", "density2d"))

qplot(carat, price, data = diamonds)
qplot(carat, price, data = diamonds, geom = "smooth")
qplot(carat, price, data = diamonds, geom = "smooth", color = cut)
qplot(carat, price, data = diamonds, geom = "smooth", group = cut)
qplot(carat, price, data = diamonds, geom = "smooth", 
  color = cut, se = FALSE)
qplot(carat, price, data = diamonds, geom = "smooth", 
  color = cut, se = FALSE, method = lm)

# Saving graphs

# Your Turn
# ---------------
getwd()
# ---------------

getwd()
dir()

ggsave("my-plot.pdf")
ggsave("my-plot.png")
ggsave("my-plot.pdf", width = 6, height = 6)


## Advanced Study
# Grammar of Graphics

# Your Turn
# ---------------------------------------------
qplot(date, unemploy, data = economics, geom = "line")
qplot(class, hwy, data = mpg, position = "jitter", color = class)
# ---------------------------------------------

# Statistical Transformations (stats)

qplot(hwy, data = mpg, geom = "histogram", binwidth = 1)

qplot(date, unemploy, data = economics[1:12, ], 
  geom = "bar", stat = "identity")

# Layers

# Your Turn
# ---------------------------
qplot(carat, price, data = diamonds, color = cut, 
  geom = c("point", "smooth"))
# ---------------------------

qplot(carat, price, data = diamonds, 
  geom = c("point", "smooth"))
qplot(carat, price, data = diamonds) + 
  geom_smooth()

?geom_smooth

geom_smooth(
  mapping = aes(x = carat, y = price, 
    color = cut), 
  data = diamonds, 
  position = "identity", 
  stat = "smooth")

# ggplot

ggplot() + 
  geom_smooth(
  mapping = aes(x = carat, y = price, 
    color = cut), 
  data = diamonds, 
  position = "identity", 
  stat = "smooth")


ggplot() + 
  geom_point(aes(x = carat, y = price), 
    data = diamonds) +
  geom_smooth(aes(x = carat, y = price, 
    color = cut), data = diamonds)

ggplot(diamonds, aes(x = carat, y = price))

ggplot(diamonds, aes(x = carat, y = price)) + 
  geom_point() +
  geom_smooth(aes(color = cut))

# Your Turn
# ---------------------------------
ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(color = drv)) +
  geom_smooth()
ggplot(mpg, aes(class, hwy)) +
  geom_point(position = "jitter", col = "grey", alpha = 0.8) +
    geom_boxplot(aes(color = class), fill = "bisque") +
    scale_color_discrete(name = "Class") +
    coord_flip()
# ----------------------------------

# Your Turn
# ---------------------------------
qplot(carat, price, data = diamonds, color = "blue")
ggplot(diamonds) +
  geom_point(aes(carat,price, color = "blue"))
# ----------------------------------

ggplot(diamonds) +
  geom_point(aes(carat, price, color = "blue"))
ggplot(diamonds) +
  geom_point(aes(carat, price), color = "blue", alpha = 0.2, position = "jitter")
