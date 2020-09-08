---
layout: post
title: "07: Learning Deconvolution Network for Semantic Segmentation"
category: "DS/DL"
comments: true
tags: [DS, "paper review", "image segmentation"]
feature-img: "assets/img/42.jpg"
feature-title: ""
use_math: true
series: "Computer Vision"
summary: "Mask R-CNN을 리뷰해본다."
---

## 개요

> Noh, H., Hong, S., and Han, B. Learning Deconvolution Network for Semantic Segmentation. ICCV, 2015.
>
> 이번 논문은 앞서 다뤘던 Fully Convolutional Networks와 같은 년도(2015)에 다른 학회(FCN은 CVPR, 본 논문은 ICCV)에 발표된 논문이다. FCN이나 이후에 다룰 UNet보다는 다소 인기가 적었지만, FCN이 가진 한계를 잘 짚어주셨다는 점에서 의의가 있다.

## 핵심 아이디어

> 크기, 디테일에 약해? -> layer 를 추가하자.

### 크기의 문제점

![](https://modulabs-biomedical.github.io/assets/images/posts/2018-01-03-Learning_Deconvolution_Network_for_Semantic_Segmentation/fig1.jpg){: .center width="80%"}

위의 예시들처럼 FCN의 추론 결과를 보면, 대상 물체가 너무 큰 경우(a)에는 파편화되고, 너무 작은 경우(b)에는 배경으로 무시되는 경향이 있다. FCN에서는 receptive field(상위 레이어의 한 지점에서 참조하는 하위 레이어의 영역)의 크기가 고정되어, 단일 배율(scale)만을 학습하는 것이 이 문제의 원인이라고 본 논문은 지적한다. 여러 레이어의 결과를 조합하는 skip 구조가 이러한 현상을 완화시켜주기는 하지만, 근본적인 해법은 아니라는 주장한다.

### Reference

[semantic segmentation의 목적과 대표 알고리즘 FCN의 원리](https://bskyvision.com/491)
