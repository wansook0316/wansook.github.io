---
layout: post
title: "12: Diverging lines with text"
category: "DS/Visualization"
comments: true
tags: [DS, "python", "matplotlib", "Diverging lines"]
feature-img: "assets/img/30.jpg"
feature-title: ""
use_math: true
series: "시각화 정리"
---

각 카테고리에 대한 값(평균, 중앙값, 표준화 값)을 비교하기 용이한 Diverging Bars에 정보를 추가해보자.  
[연습 kaggle notebook](https://www.kaggle.com/wansook0316/plotting-with-python-learn-80-plots-step-by-step/edit)


```python
# Useful for:
# This plot is really useful to show the different performance of deviation of data.
# We use text to annotate the value and make more easy the comparison.

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

# plot horizontal lines that go from zero to the value
# here we make the linewidht very thin.
ax.hlines(y = df.index, xmin = 0 , color = colors,  xmax = df["x_plot"], linewidth = 1)

# ----------------------------------------------------------------------------------------------------
# plot the data
# iterate over x and y and annotate text and plot the data
for x, y in zip(df["x_plot"], df.index):
    # annotate text
    ax.text(x - 0.1 if x < 0 else x + 0.1, 
             y, 
             round(x, 2), 
             color = "red" if x < 0 else "green",  
             horizontalalignment='right' if x < 0 else 'left', 
             size = 10)
    # plot the points
    ax.scatter(x, 
                y, 
                color = "red" if x < 0 else "green", 
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

# make a grid
ax.grid(linestyle='--', alpha=0.5)

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
ax.spines['right'].set_color('black')
```



![다운로드 (14)](https://user-images.githubusercontent.com/37871541/83345169-fd40a100-a34a-11ea-9f70-4e3b9adefdb0.png){:.center-text}



### Reference
[Plotting with Python: learn 80 plots STEP by STEP](https://www.kaggle.com/python10pm/plotting-with-python-learn-80-plots-step-by-step)