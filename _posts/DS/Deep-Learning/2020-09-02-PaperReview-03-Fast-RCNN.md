---
layout: post
title: "03: Fast R-CNN"
category: "DS/DL"
comments: true
tags: [DS, "paper review"]
feature-img: "assets/img/42.jpg"
feature-title: ""
use_math: true
series: "Paper Review"
summary: "Fast R-CNN을 리뷰해본다."
---

## 핵심 아이디어

> Feature Extraction, classification, bounding box regression까지 한번에 학습할 수 있는 모델을 만들자!

Fast R-CNN은 이전 SSP Net이 가지는 한계점을 극복하는 시도에서 출발한다. SSP Net은 1) Multi stage model이고 2) FC layer 만 학습 시킬 수 있다는 한계점이 있었다.

![](https://media.geeksforgeeks.org/wp-content/uploads/20200219160147/fast-RCNN1.png){: .center width="80%"}_Fast R-CNN Architecture_

## 알고리즘

1. pretrained model로 부터 feature map을 추출한다.
2. Selective Search를 통해 찾은 각각의 ROI에 대해 **\*ROI Pooling**을 진행한다. 그 결과로 고정된 크기의 feature vector를 얻는다.
3. feature vector는 FC layer를 통과하고 두개의 branch로 나뉜다.
4. 하나의 branch에서는 softmax를 통과하여 해당 ROI가 어떤 물체인지 clasification을 진행한다.
5. 다른 branch에서는 bounding box regression을 통해 selective search로 찾은 박스의 위치를 조정한다.

핵심 의의는 multi stage model에서 end-to-end로 model을 구성했다는 것에 있다. 결과적으로도 속도, 정확도, 학습 속도 모두를 향상시켰다는데 의의가 있다.

## ROI polling

Roi pooling의 아이디어는 앞서 보았던 SPP Net과 유사하다. SPP Net은, pretrained model으로 부터 도출되는 feature map으로 부터, 피라미드 filter를 거친 후 이를 vectorize 하여 고정된 개수의 vector를 얻을 수 있었다. 이 아이디어를 조금 변경하여 제시하는 것이 Roi pooling이다.

![](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FmF4V0%2FbtqAVGST2nx%2FNhjfsG6vd89TgIK5bn2Ha0%2Fimg.png){:. center width="80%"}_ROI pooling_

1. feature map에서 Selective search를 통해 Resion Proposal을 진행한다.
2. 이 proposal에 Roi pooling을 진행하여 고정된 형태의 작은 feature map을 만든다.

Roi pooling은, Resion Proposal을 고정된 형태의 output 모양으로 바꾼다. (H x W) 크기의 feature map을 output으로 원한다면, proposal을 이에 맞게 칸을 나눈 후, max pooling을 진행한다. 이렇게 되면 항상 같은 크기의 결과를 얻을 수 있다.

## Multi Task Loss

딥러닝을 공부하면서 가장 새롭고 즐거웠던 부분은 손실함수 부분이었다. object detection은 기본적으로 bounding box regression과 classication을 동시에 진행해야 하는 Task이다. 그래서 예전 접근은 multi stage로 이루어졌었다. 하지만 이 Fast R-CNN에서 처음으로 이 두가지 task를 하나로 엮는 방법이 고안된다.

우리는 이미지로 부터 feature map을 추출했고, 이 feature map에서 Roi를 제안 받아 Roi pooling을 통해 feature vector를 만들었다. 이제 이 벡터로 classification과 bounding box regression을 적용하여 각각의 loss를 얻어내고, 이를 back propagation하여 전체 모델을 학습시키면 된다. 이 두 Task 모두를 반영한 손실함수를 보자.

$$
L(p, u, t^u, v) = L_{cls}(p, u) + \lambda[u \ge 1]L_{loc}(t^u, v)
$$

각 변수 하나하나에 대해서 알아보자. 먼저, $p$ 는, Softmax를 통해 얻어낸 $K+1$ 개의 확률값이다.(이산 확률 분포) $K+1$인 이유는 K개의 object와 배경(아무 물체도 아님)을 추가한 것이다. $u$는 해당 Roi의 ground truth label 벡터이다.

$$
p = (p_0, ..., p_n,..., p_k)\\
u = (0, ..., 1, ..., 0)
$$

다음으로는 bounding box regression을 진행한다. 고정 처리된 feature map을 가지고 regression을 했을 때 결과는,

### Reference

[갈아먹는 Object Detection [3] Fast R-CNN](https://yeomko.tistory.com/15?category=888201)
