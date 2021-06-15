---
layout: post
title: "13: Diverging Lollipop Chart with Markers"
category: "DS/Visualization"
comments: true
tags: [DS, "python", "matplotlib", "Diverging lines"]
feature-img: "assets/img/9.jpg"
feature-title: ""
use_math: true
series: "시각화 정리"
---

각 카테고리에 대한 값(평균, 중앙값, 표준화 값)을 비교하기 용이한 Diverging Bars를 동그라미로 나타내보자.  
[연습 kaggle notebook](https://www.kaggle.com/wansook0316/plotting-with-python-learn-80-plots-step-by-step/edit)

```python
# Useful for:
# This plot is really useful to show the different performance of deviation of data.
# We use text to annotate the value and make more easy the comparison.
# This plot is very similar to the previous 2
# But here we don't draw any lines and just play with the size of each point and make it a little bigger

# More info:
# https://blog.datawrapper.de/divergingbars/

# ----------------------------------------------------------------------------------------------------
# get the data
PATH = "/kaggle/input/the-50-plot-challenge/mtcars.csv"
df = pd.read_csv(PATH)

# ----------------------------------------------------------------------------------------------------
# prepare the data for plotting
# here we standarize the data
# More info:
# https://statisticsbyjim.com/glossary/standardization/
df["x_plot"] = (df["mpg"] - df["mpg"].mean())/df["mpg"].std()

# sort value and reset the index
df.sort_values("x_plot", inplace = True)
df.reset_index(inplace=True)

# create a color list, where if value is above > 0 it's green otherwise red
colors = ["red" if x < 0 else "green" for x in df["x_plot"]]


# ----------------------------------------------------------------------------------------------------
# instanciate the figure
fig = plt.figure(figsize = (10, 8))
ax = fig.add_subplot()

# ----------------------------------------------------------------------------------------------------
# plot the data
# iterate over x and y and annotate text and plot the data
for x, y in zip(df["x_plot"], df.index):

    # make a horizontal line from the y till the x value
    # this doesn't appear in the original 50 plot challenge
    ax.hlines(y = y,
               xmin = -3,
               xmax = x,
               linewidth = 0.5,
               alpha = 0.3,
               color = "red" if x < 0 else "green")

    # annotate text
    ax.text(x,
             y,
             round(x, 2),
             color = "black",
             horizontalalignment='center',
             verticalalignment='center',
             size = 8)

    # plot the points
    ax.scatter(x,
                y,
                color = "red" if x < 0 else "green",
                s = 300,
                alpha = 0.5)

# ----------------------------------------------------------------------------------------------------
# prettify the plot
# set title
ax.set_title("Diverging plot in matplotlib")

# change x lim
ax.set_xlim(-3, 3)

# set labels
ax.set_xlabel("Mileage")
ax.set_ylabel("Car Name")

# instead of y = 1, 2, 3...
# put the car makers on the y axis
ax.set_yticks(df.index)
ax.set_yticklabels(df.cars)

# change the spines to make it nicer
ax.spines["top"].set_color("None")
ax.spines["left"].set_color("None")

# with this line, we change the right spine to be in the middle
# as a vertical line from the origin
ax.spines['right'].set_position(('data',0))
ax.spines['right'].set_color('grey')
```

![다운로드 (17)](https://user-images.githubusercontent.com/37871541/83345472-6c6bc480-a34e-11ea-9e14-edc3774cc14a.png){:.center-text}

## Patch를 좀 더 간단하게

```python
# Useful for:
# This plot is really useful to show the different performance of deviation of data.
# In this plot we use rectagles and matplotlib patches to draw the attention to specific points
# This example shows how to add patches more easily

# More info:
# https://blog.datawrapper.de/divergingbars/

# ----------------------------------------------------------------------------------------------------
# get the data
PATH = "/kaggle/input/the-50-plot-challenge/mtcars.csv"
df = pd.read_csv(PATH)

# ----------------------------------------------------------------------------------------------------
# prepare the data for plotting
# here we standarize the data
# More info:
# https://statisticsbyjim.com/glossary/standardization/
df["x_plot"] = (df["mpg"] - df["mpg"].mean())/df["mpg"].std()

# sort value and reset the index
df.sort_values("x_plot", inplace = True)
df.reset_index(inplace = True)

# we plot everything with a black color except a specific Fiat model
# this way we visually communicate something to the user
df["color"] = df["cars"].apply(lambda car_name: "orange" if car_name == "Fiat X1-9" else "black")


# ----------------------------------------------------------------------------------------------------
# instanciate the figure
fig = plt.figure(figsize = (8, 12))
ax = fig.add_subplot()

# ----------------------------------------------------------------------------------------------------
# plot the data
# plot horizontal lines from the origin to each data point
ax.hlines(y = df.index,
          xmin = 0,
          xmax = df["x_plot"],
          color = df["color"],
          alpha = 0.6)

# plot the dots
ax.scatter(x = df["x_plot"],
          y = df.index,
          s = 100,
          color = df["color"],
          alpha = 0.6)

# add patches more easily
# It's easier to draw shapes like rectangles or squares, since this way
# we only must specify 2 points, and matplotlib does all the job
p1 = patches.Rectangle((-2.0, -1), width = .3, height = 3, alpha = .2, facecolor = 'red')
p2 = patches.Rectangle((1.5, 27), width = .8, height = 5, alpha = .2, facecolor = 'green')
ax.add_patch(p1)
ax.add_patch(p2)

# annotate text
ax.annotate('Mercedes Models',
            xy = (0.0, 11.0),
            xytext = (1.5, 11),
            xycoords = 'data',
            fontsize = 10,
            ha = 'center',
            va = 'center',
            bbox = dict(boxstyle = 'square', fc = 'blue', alpha = 0.1),
            arrowprops = dict(arrowstyle = '-[, widthB=2.0, lengthB=1.5', lw = 2.0, color = 'grey'), color = 'black')

# ----------------------------------------------------------------------------------------------------
# prettify the plot
# set title
ax.set_title("Diverging Lollipop of Car Mileage")

# autoscale
ax.autoscale_view()

# change x lim
ax.set_xlim(-3, 3)

# set labels
ax.set_xlabel("Mileage")
ax.set_ylabel("Car Name")

# instead of y = 1, 2, 3...
# put the car makers on the y axis
ax.set_yticks(df.index)
ax.set_yticklabels(df.cars)

# change the spines to make it nicer
ax.spines["right"].set_color("None")
ax.spines["top"].set_color("None")

# add a grid
ax.grid(linestyle='--', alpha=0.5);
```

![다운로드 (16)](https://user-images.githubusercontent.com/37871541/83345465-61189900-a34e-11ea-9a19-d4f0f30b5076.png){:.center-text}

### Reference

[Plotting with Python: learn 80 plots STEP by STEP](https://www.kaggle.com/python10pm/plotting-with-python-learn-80-plots-step-by-step)
