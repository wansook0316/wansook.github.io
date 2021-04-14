---
layout: post
title: "matplot에서 opencv로 load한 사진 plot하기"
category: "DV/Concept"
comments: true
tags: [Concept, "matplotlib", "opencv", "RGB", "BGR"]
feature-img: "assets/img/74.jpg"
feature-title: ""
use_math: true
summary: "opencv와 matplotlib에서 사진을 받아먹는 형태가 다르다."
---


컬러 사진을 OpenCV에서는 BGR 순서로 저장하는데 matplotlib에서는 RGB 순서로 저장한다. 따라서 BGR을 RGB로 바꾸어 주어야만 사진이 제대로 표시된다.

```python
import cv2
import matplotlib.pyplot as plt

BGR = cv2.imread("test.jpg")
RGB = cv2.cvtColor(BGR, cv2.COLOR_BGR2RGB) # convert color

# 출력 부분
plt.imshow(RGB, interpolation='bicubic')
plt.show()

```
