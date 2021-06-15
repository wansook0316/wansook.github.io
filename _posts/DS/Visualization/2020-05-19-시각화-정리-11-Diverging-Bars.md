---
layout: post
title: "11: Diverging Bars"
category: "DS/Visualization"
comments: true
tags: [DS, "python", "matplotlib", "Diverging Bars"]
feature-img: "assets/img/9.jpg"
feature-title: ""
use_math: true
series: "시각화 정리"
---

각 카테고리에 대한 값(평균, 중앙값, 표준화 값)을 비교하기 용이한 Diverging Bars을 알아본다.  
[연습 kaggle notebook](https://www.kaggle.com/wansook0316/plotting-with-python-learn-80-plots-step-by-step/edit)

```python
# Useful for:
# Based on a metric to compare, this plot helps you to see the divergence of the a value
# to that metric (it could be mean, median or others).

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
# sort를 하게되면 index가 제멋대로 배열된다.
# 우리는 배열된 이후의 index를 다시 갖고 싶은 것이기 때문에 index를 정렬후 새로 만들어준다.
# 이 때, drop = True, inplace = True가 있는데 drop은 재생성한 후 이전 것을 버리는 것을 의미한다.
# inplace는 원본 데이터를 대체할 것인지, 아니면 변경된 객체를 반환할 것인지를 결정한다.
df.sort_values("x_plot", inplace = True)
df.reset_index(inplace = True)

# create a color list, where if value is above > 0 it's green otherwise red
colors = ["red" if x < 0 else "green" for x in df["x_plot"]]

# ----------------------------------------------------------------------------------------------------
# instanciate the figure
fig = plt.figure(figsize = (10, 8))
ax = fig.add_subplot()
# plot using horizontal lines and make it look like a column by changing the linewidth
# 가로선을 그음으로써 원하는 그래프와 비슷한 모양을 만든다.
ax.hlines(y = df.index, xmin = 0 , xmax = df["x_plot"],  color = colors, linewidth = 5)

# ----------------------------------------------------------------------------------------------------
# prettify the plot
# set x and y axis
ax.set_xlabel("Mileage")
ax.set_ylabel("Car Name")

# set a title
ax.set_title("Diverging plot in matplotlib")

# make a grid to help separate the lines
ax.grid(linestyle='--', alpha=0.5)

# change the y ticks
# first you set the yticks
# 먼저 y에 index를 박고,
ax.set_yticks(df.index)

# then you change them using the car names
# same can be achived using plt.yticks(df.index, df.cars)
# 그 index에 맞는 차를 넣어준다.
# 이 때, ;를 추가하여 output이 나오지 않게 만들어준다.
ax.set_yticklabels(df.cars);
```

![다운로드 (13)](https://user-images.githubusercontent.com/37871541/82284233-7ba85500-99d3-11ea-8958-e751b995326e.png)
{:.center-text}

### Reference

[Plotting with Python: learn 80 plots STEP by STEP](https://www.kaggle.com/python10pm/plotting-with-python-learn-80-plots-step-by-step)
