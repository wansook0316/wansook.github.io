---
layout: post
title: "07: Mask R-CNN"
category: "DS/DL"
comments: true
tags: [DS, "paper review", "image segmentation"]
feature-img: "assets/img/42.jpg"
feature-title: ""
use_math: true
series: "Computer Vision"
summary: "Mask R-CNN을 리뷰해본다."
---

원래대로라면, YOLO를 리뷰해야 하나, 일단은 같은 계열인 Mask RCNN부터 리뷰해보자. 해당 논문은 Faster R-CNN을 확장하여 Instance Segmentation에 적용하고자 하는 모델이다.

## 핵심 아이디어

> Faster R-CNN에서 detect한 각각의 box에 mask를 씌워주자!

### Reference

[갈아먹는 Object Detection [4] Faster R-CNN](https://yeomko.tistory.com/17?category=888201)
