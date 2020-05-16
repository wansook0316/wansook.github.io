---
layout: post
title: "09: Marginal Boxplot"
category: "DS/Visualization"
comments: true
tags: [DS, "python", "matplotlib", "Marginal Boxplot"]
feature-img: "assets/img/30.jpg"
feature-title: ""
use_math: true
series: "시각화 정리"
---

Scatter Plot에 각각의 boxplot을 추가해보자.  
[연습 kaggle notebook](https://www.kaggle.com/wansook0316/plotting-with-python-learn-80-plots-step-by-step/edit)


```python
sns.set_style("whitegrid")

# Useful for:
# A box plot or boxplot is a method for graphically depicting groups of numerical data through their quartiles.
# It helps to see the dispersion of a series, thanks to the whiskers

# More info: 
# https://en.wikipedia.org/wiki/Box_plot

# ----------------------------------------------------------------------------------------------------
# get the data
PATH = '/kaggle/input/the-50-plot-challenge/mpg_ggplot2.csv'
df = pd.read_csv(PATH)


# ----------------------------------------------------------------------------------------------------
# prepare the data for plotting
x = df["displ"]
y = df["hwy"]

# in this plot we create the colors separatly
colors = df["manufacturer"].astype("category").cat.codes

# ----------------------------------------------------------------------------------------------------
# instanciate the figure
fig = plt.figure(figsize = (10, 5))
# in this case we use gridspec.
# check the basics section of this kernel if you need help.
gs = fig.add_gridspec(6, 6)
ax1 = fig.add_subplot(gs[:4, :-1])

# ----------------------------------------------------------------------------------------------------
# plot the data

# main axis: scatter plot
# this line is very nice c = df.manufacturer.astype('category').cat.codes
# since it basically generate a color for each category
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

# using familiar slicing, get the left axes and plot
ax2 = fig.add_subplot(gs[4:, :-1])
ax2.boxplot(x, 
            vert = False,  
            whis = 0.75 # make the boxplot lines shorter
           )
# prettify the plot
# set the ticks to null
ax2.set_xticks([])
ax2.set_yticks([])


# left plot
ax3 = fig.add_subplot(gs[:4, -1])
ax3.boxplot(y,  
            whis = 0.75 # make the boxplot lines shorter
           )
# prettify the plot
# set the ticks to null
ax3.set_xticks([])
ax3.set_yticks([])

# make all the figures look nicier
fig.tight_layout()
```


![다운로드 (8)](https://user-images.githubusercontent.com/37871541/82113906-4c57d500-9794-11ea-9d57-4b64f45b0fb7.png)
{:.center-text}



### Reference
[Plotting with Python: learn 80 plots STEP by STEP](https://www.kaggle.com/python10pm/plotting-with-python-learn-80-plots-step-by-step)