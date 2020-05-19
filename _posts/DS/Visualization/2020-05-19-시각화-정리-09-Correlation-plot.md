---
layout: post
title: "09: Correlation plot"
category: "DS/Visualization"
comments: true
tags: [DS, "python", "matplotlib", "Correlation plot"]
feature-img: "assets/img/30.jpg"
feature-title: ""
use_math: true
series: "시각화 정리"
---

변수들의 상관관계를 한눈에 파악할 수 있는 Correlation plot을 알아본다.  
[연습 kaggle notebook](https://www.kaggle.com/wansook0316/plotting-with-python-learn-80-plots-step-by-step/edit)


```python
# Useful for:
# The correlation plot helps us to comparte how correlated are 2 variables between them

# More info: 
# https://en.wikipedia.org/wiki/Covariance_matrix#Correlation_matrix

# ----------------------------------------------------------------------------------------------------
# get the data
PATH = '/kaggle/input/the-50-plot-challenge/mtcars.csv'
df = pd.read_csv(PATH)

# ----------------------------------------------------------------------------------------------------
# instanciate the figure
fig = plt.figure(figsize = (10, 5))
ax = fig.add_subplot()

# plot using matplotlib
# https://matplotlib.org/3.2.1/api/_as_gen/matplotlib.axes.Axes.imshow.html
ax.imshow(df.corr(), cmap = 'viridis', interpolation = 'nearest')
# set the title for the figure
ax.set_title("Heatmap using matplotlib");
```


![다운로드 (9)](https://user-images.githubusercontent.com/37871541/82282399-b1970a80-99ce-11ea-878a-861cf187499c.png){:.center-text width="500"}


단순히 이렇게만 plot하면 알아보는 것이 어려우니, x, y축에 변수이름을 적어 나타내어 보자.

```python
# Useful for:
# The correlation plot helps us to comparte how correlated are 2 variables between them

# More info: 
# https://en.wikipedia.org/wiki/Covariance_matrix#Correlation_matrix

# ----------------------------------------------------------------------------------------------------
# get the data
PATH = '/kaggle/input/the-50-plot-challenge/mtcars.csv'
df = pd.read_csv(PATH)

# ----------------------------------------------------------------------------------------------------
# prepare the data for plotting
# calculate the correlation between all variables
corr = df.corr()
# create a mask to pass it to seaborn and only show half of the cells 
# because corr between x and y is the same as the y and x
# it's only for estetic reasons
mask = np.zeros_like(corr) # 0행렬을 만든다.
mask[np.triu_indices_from(mask)] = True # upper triangle 부분을 true로 바꾼다.

# ----------------------------------------------------------------------------------------------------
# instanciate the figure
fig = plt.figure(figsize = (10, 5))

# plot the data using seaborn
ax = sns.heatmap(corr, 
                 mask = mask, 
                 vmax = 0.3, 
                 square = True,  
                 cmap = "viridis")
# set the title for the figure
ax.set_title("Heatmap using seaborn");
```

![다운로드 (10)](https://user-images.githubusercontent.com/37871541/82282656-587ba680-99cf-11ea-9121-87599c2c7613.png){:.center-text width="500"}



### Reference
[Plotting with Python: learn 80 plots STEP by STEP](https://www.kaggle.com/python10pm/plotting-with-python-learn-80-plots-step-by-step)