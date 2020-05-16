---
layout: post
title: "08: Marginal Histogram"
category: "DS/Visualization"
comments: true
tags: [DS, "python", "matplotlib", "Marginal Histogram"]
feature-img: "assets/img/30.jpg"
feature-title: ""
use_math: true
series: "시각화 정리"
---

Scatter Plot에 각각의 histogram을 추가해보자.  
[연습 kaggle notebook](https://www.kaggle.com/wansook0316/plotting-with-python-learn-80-plots-step-by-step/edit)


```python
# Useful for:
# This plot is a combination of 2 plots.
# On one side we have a normal scatter plot that is helpful to see the relationship between data (x and y axis)
# But we also add a histogram that is useful to see the concentration/bins and the distribution of a series.

# More info: 
# https://en.wikipedia.org/wiki/Histogram

# ----------------------------------------------------------------------------------------------------
# get the data
PATH = '/kaggle/input/the-50-plot-challenge/mpg_ggplot2.csv'
df = pd.read_csv(PATH)

# ----------------------------------------------------------------------------------------------------
# prepare the data for plotting
# separate x and y
x = df["displ"]
y = df["hwy"]

# ----------------------------------------------------------------------------------------------------
# instanciate the figure
fig = plt.figure(figsize = (10, 5))
# in this case we use gridspec.
# check the basics section of this kernel if you need help.
gs = fig.add_gridspec(5, 5)
ax1 = fig.add_subplot(gs[:4, :-1])

# ----------------------------------------------------------------------------------------------------
# plot the data

# main axis: scatter plot
# this line is very nice c = df.manufacturer.astype('category').cat.codes
# since it basically generate a color for each category
# 이렇게 하면 카테고리별 색상을 구해준다. 총 78개의 category가 있는 것으로 보인다.
ax1.scatter(x, y, c = df.manufacturer.astype('category').cat.codes) 


# set the labels for x and y
ax1.set_xlabel("Dist")
ax1.set_ylabel("Hwy")

# set the title for the main plot
ax1.set_title("Scatter plot with marginal histograms")

# prettify the plot
# get rid of some of the spines to make the plot nicer
ax1.spines["right"].set_color("None")
ax1.spines["top"].set_color("None")

# using familiar slicing, get the bottom axes and plot
ax2 = fig.add_subplot(gs[4:, :-1])
ax2.hist(x, 40, orientation = 'vertical', color = "pink")

# invert the axis (it looks up side down)
ax2.invert_yaxis()

# prettify the plot
# set the ticks to null
ax2.set_xticks([])
ax2.set_yticks([])
# no axis to make plot nicer
ax2.axison = False

# using familiar slicing, get the left axes and plot
ax3 = fig.add_subplot(gs[:4, -1])
ax3.hist(y, 40, orientation = "horizontal", color = "pink")

# prettify the plot
# set the ticks to null
ax3.set_xticks([])
ax3.set_yticks([])
# no axis to make plot nicer
ax3.axison = False

# make all the figures look nicier
fig.tight_layout()

```

![다운로드 (7)](https://user-images.githubusercontent.com/37871541/82113783-9ab8a400-9793-11ea-9f49-4f2c82eeb6f0.png){:.center-text}


### Reference
[Plotting with Python: learn 80 plots STEP by STEP](https://www.kaggle.com/python10pm/plotting-with-python-learn-80-plots-step-by-step)