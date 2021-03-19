---
layout: post
title: "16: Single Shot Multibox Detector"
category: "DS/DL"
comments: true
tags:
  [
    DataScience,
    "DeepLearning",
    "Computer-Vision",
    "Paper-Review",
    "Detection",
  ]
feature-img: "assets/img/70.jpg"
feature-title: ""
use_math: true
series: "Computer Vision"
summary: "Faster RCNN 이후 1 stage model을 구현한 SDD에 대해 리뷰해본다."
---

# 개요
![image](https://user-images.githubusercontent.com/37871541/111717614-bd2bba00-889b-11eb-987b-74c4afca8eda.png)

이제는 오랜 시간이 지난 논문인 SSD를 **간단하게** 리뷰 해보려 한다. 매우 직관적인 구조를 가지고 있어 많은 구조가 이 SSD를 기반으로 만들어지고 있다. YOLO v1 이후에 나온 논문으로 1 stage detector의 성격을 가지나 아키텍쳐는 전혀 다른, 오히려 RCNN 계열과 비슷한 특징을 가진다. SSD 알고리즘을 한 문장으로 정리하면, feature map을 만드는 공간을 나누어 진행한다. 그리고 각 feature map에서 다른 비율과 스케일로 default box를 생성하고, 이 box를 기반으로 모델을 통과 시켜 좌표와 클래스를 계산한다. 마지막으로 이 값을 기반으로 최종 bounding box를 생성한다.

# Model
Image Detection은 이미지가 있을 때, 이미지 안에 들어있는 사물을 찾는 문제이다. 여기서 찾는다는 것은 사물들의 위치와 크기를 알아내고, 물체를 검출하는 것이다. 즉, image pixel이 들어갔을 때, 사물이 어떤 class인지 나타내는 class 점수와, 사물의 offset(x, y, w, h)를 output으로 뱉는 함수를 만들면 된다.

![image](https://user-images.githubusercontent.com/37871541/111717964-7b4f4380-889c-11eb-980d-02b4ef1fb041.png)

SSD의 아키텍쳐는 위와 같다. 직관적으로 이해가 될 만큼 간단한 구조이다. 먼저 SSD는 Transfer learning을 위해 FC layer를 제외한 VGG-16아키텍쳐를 사용했다. 그 뒤의 추가적인 네트워크로는 **CONV**를 사용하여 **다양한 크기**로 feature를 추출하고 이 feature에서 각각 detection을 수행한다.

## Convolution Predictors

마지막 예측 단계에서 과감하게 FC later를 삭제하고 CONV만을 이용하여 예측을 진행한다.  그렇기 때문에 굉장히 빠른 속도를 보여준다.

## Multi-scale Feature Maps
다양한 크기의 물체에 대해 정답을 맞출 수 있다. feature map은 깊어질 수록 보다 추상적인 정보를 담는다. 다양한 feature에서 scale에 덜 민감하도록 예측하는 방식은 크기에 상관없이 물체의 특징을 잡아낼 수 있는 방법이다.

## Default Boxes and Aspect Ratios
![image](https://user-images.githubusercontent.com/37871541/111719434-34af1880-889f-11eb-8a1c-98e14bc19303.png)

위의 아키텍쳐를 보게되면 각각의 feature map에서 추출하는 class의 개수가 표현되어 있다. 어떤 의미인지 알아보자. 

> classifier : CONV: 3x3(6x(classes+4))

분류기로 CONV를 사용하고, 3x3의 필터를 사용할 것이고 (channel은 어차피 이전 네트워크의 channel과 같아야 하니 표현하지 않은 듯) default box를 기준으로(사전에 정의해둔 box들) 6개의 box를 뽑을 것이며, 그리고 class의 개수 만큼 예측하고, 각각의 bounding box의 예측값(x, y, w, h)를 포함한 개수만큼을 뽑을 거야. 라는 이야기다.

예를 들어 설명해보자. 만약 내가 사전에 모양을 잡아둔 default box가 6개라고 해보자. 그리고 물체의 class 종류는 21개이다. 그렇다면 convolution 필터의 개수는 6개의 box에 대해서 각각 21+4개의 값을 예측해야 하므로 150 x (21+4) = 150 개의 채널이 필요하다.

## Process

![image](https://user-images.githubusercontent.com/37871541/111718760-dfbed280-889d-11eb-8415-c50bbc7b3395.png)


1. 300x300x3짜리 이미지를 VGG-16를 통과시켜 38x38x512의 feature map을 생성한다.
2. 다양한 크기의 feature map을 크기를 줄여가면서 생성한다.
3. 각각의 feature map에서 사전에 정의된 default box를 적용하여 y값을 예측한다.
   * 이 때, 각각의 default box와 gt box와의 최적 매칭을 진행하기 위한 metric으로 IoU(Jaccard overlap)을 사용한다. 
   * threshold를 도입하여 일정 이하의 매칭은 제거한다.
4. threshold를 통과한 모든 아웃풋을 한데 묶어 NMS을 진행하고 결과를 생성한다.


# Training
찬찬히 알아보자...




# Reference

