---
layout: post
title: "15: Ordered Bar Chart"
category: "DS/Visualization"
comments: true
tags: [DS, "python", "matplotlib", "Diverging lines"]
feature-img: "assets/img/9.jpg"
feature-title: ""
use_math: true
series: "시각화 정리"
---

feature를 정리한 후 히스토그램을 그려보자.

```python
# Useful for:
# This is a normal bar chart but ordered in a specific way.
# From the lowest to the highest values
# It's useful to show comparisons among discrete categories.

# More info:
# https://en.wikipedia.org/wiki/Bar_chart

# ----------------------------------------------------------------------------------------------------
# get the data
PATH = "/kaggle/input/the-50-plot-challenge/mpg_ggplot2.csv"
df = pd.read_csv(PATH)

# ----------------------------------------------------------------------------------------------------
# prepare the data for plotting
# groupby and create the target x and y
gb_df = df.groupby(["manufacturer"])["cyl", "displ", "cty"].mean()
gb_df.sort_values("cty", inplace = True)
# fitler x and y
x = gb_df.index
y = gb_df["cty"]

# ----------------------------------------------------------------------------------------------------
# instanciate the figure
fig = plt.figure(figsize = (10, 8))
ax = fig.add_subplot()

# ----------------------------------------------------------------------------------------------------
# plot the data
for x_, y_ in zip(x, y):
    # this is very cool, since we can pass a function to matplotlib
    # and it will plot the color based on the result of the evaluation
    ax.bar(x_, y_, color = "red" if y_ < y.mean() else "green", alpha = 0.3)

     # add some text
    ax.text(x_, y_ + 0.3, round(y_, 1), horizontalalignment = 'center')

# ----------------------------------------------------------------------------------------------------
# prettify the plot

# Add a patch below the x axis line to enphasize that they are below the mean
# I had to copy and paste this code, since I didn't manage to figure it out.
# red one
p2 = patches.Rectangle((.124, -0.005), width = .360, height = .13, alpha = .1, facecolor = 'red', transform = fig.transFigure)
fig.add_artist(p2)

# green one
p1 = patches.Rectangle((.124 + .360, -0.005), width = .42, height = .13, alpha = .1, facecolor = 'green', transform = fig.transFigure)
fig.add_artist(p1)

# rotate the x ticks 90 degrees
ax.set_xticklabels(x, rotation=90)

# add an y label
ax.set_ylabel("Average Miles per Gallon by Manufacturer")

# set a title
ax.set_title("Bar Chart for Highway Mileage");
```

![다운로드 (19)](https://user-images.githubusercontent.com/37871541/83345564-8a85f480-a34f-11ea-801e-a0146a864368.png){:.center-text}

### Reference

[Plotting with Python: learn 80 plots STEP by STEP](https://www.kaggle.com/python10pm/plotting-with-python-learn-80-plots-step-by-step)
