---
layout: post
title: "05: Faster R-CNN"
category: "DS/DL"
comments: true
tags: [DS, "paper review"]
feature-img: "assets/img/42.jpg"
feature-title: ""
use_math: true
series: "Computer Vision"
summary: "Faster R-CNN을 리뷰해본다."
---

## 핵심 아이디어

> Region Proposal도 Network안에 포함시키자!

Faster R-CNN의 핵심 아이디어는 Resion Proposal Network(이하 RPN)이다. 기존 Fast R-CNN구조를 계승하면서 `selective search`를 제거하고 RPN을 통해서 `Roi`를 계산한다. 이를 통해서 GPU를 통해 `Roi`를 계산할 수 있게 되었고, 이 `RoI`를 추출하는 것 역시 학습시켜 정확도를 높일 수 있다. 결과적으로 `selective search`가 2000개 `RoI`를 계산하는데 반해, 800개 정도로 더 높은 정확도를 가진다.

~[](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbUjRYz%2FbtqAWb0p8cv%2Fdx8Ky33sdZtb2RKQ8sQxZK%2Fimg.png){: .center width="80%"}_Faster R-CNN structure_

그림을 보면 알겠지만, `feature map`으로 부터 `selective search`를 거치치 않고 이를 RPN에 전달하여 계산을 진행한다. 여기서 얻은 `RoI`로 `RoI Pooling`을 진행한 다음 object detection을 진행한다.

# Region Proposal Network

![](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fo7PTm%2FbtqAXir1rPy%2FVbzsfY9JMY9N3ixCe3zxb0%2Fimg.png){: .center width="80%"}_Region Proposal Network structure_

이 그림보다는 순차적으로 된 그림으로 이해하는 것이 쉽다.

![](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fb7xNNb%2FbtqAYHyrFDU%2FJDkko5dBYTMzZV96AcpakK%2Fimg.png){: .center width="80%"}_Region Proposal Network structure_

1. CNN을 통해 뽑아낸 feature map을 입력으로 받는다. 어떤 pretrained model을 사용할 지 모르므로 이를 `H x W x C`로 둔다.
2. feature map에 `(3 x 3) x 256` 또는 `(3 x 3) x 512` conv 연산을 수행한다. 엄밀히 말하면 C와 256, 512는 같아야 한다. 일단 연산이 가능하다고 가정하자. 이 때, `H x W`가 보존될 수 있게 padding을 1로 설정한다.
3. 2번의 과정에서 나온 feature map을 가지고 classification을 위한 확률값과, bounding box regression 값을 뽑아낸다. 이 과정에서 너무 많은 연산을 진행하게 되면 모델이 지나치게 무거워 진다. 저자들은 `1 x 1 conv`만을 수행하여 예측값을 뽑아내고자 하였다.

![image](https://user-images.githubusercontent.com/37871541/92203883-385bee80-eebd-11ea-9782-e8e3c0e5c95d.png){: .center width="60%"}_Anchor_

4. 먼저, Classification의 경우, 더욱 가볍게 진행하기 위해 물체인지 아닌지를 구분하는 binary classification을 진행하고자 하였다. 하지만 이 문제는 bounding box와 엮어서 이를 생각해야 하는데, 저자들은 이 단계에서 Anchor라는 개념을 도입하여 이를 진행하였다. Anchor는 간단하게 사전에 정의해 둔 Box들이다. 총 9개를 사용하였다. 이 모든 내용을 정리하면, classification의 결과는 총 `(H x W)`의 각각의 위치에 제안된 Anchor(9개)에 대해 물체의 여부(2)를 나타내는 총 18개의 Node를 가져야 한다. 그러기 위해 `(1 x 1) x (2 x 9)`의 conv 연산을 진행하였다. 결과적으로 `(H x W) x (2 x 9)`의 Feature map이 나오고, 각각의 노드는 순서대로 `(h, w)` 위치에 있는 1번 anchor가 물체일 logit, `(h, w)` 위치에 있는 1번 anchor가 물체가 아닐 logit ... 로 정의된다. 최종적으로 이를 확률 값으로 변경해주기 위해 적절히 reshape 해준 다음 Softmax를 적용한다.
5. 두번째로 Bounding Box Regression을 진행한다. 같은 방법을 사용한다. 이번에는 9개 anchor에 대해 총 4개의 좌표를 수정하기 위한 조절값을 예측해야 하므로 `(H x W) x (4 x 9)`의 결과를 얻어야 한다. 이번에는 regression이기 때문에 그대로 결과값으로 사용하면 된다.
6. 4번 5번의 과정은 순차적으로 진행된다. 즉, classification을 먼저 진행하고, 이 결과를 기반으로 물체일 확률을 sorting한다. 이 중 높은 순으로 K개의 anchor를 후보군으로 선정한다. 이 후보군에 각각 bounding Box Regression을 진행한다. 마지막으로 Non-Maximum-Suppression을 적용하고, 이것을 기반으로 RoI를 제안한다.

이러한 방법을 통해서 RoI를 제안하는 Network를 만들었다. 이 후 과정은, 이렇게

### Reference

[갈아먹는 Object Detection [4] Faster R-CNN](https://yeomko.tistory.com/17?category=888201)
