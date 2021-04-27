---
layout: post
title: "08: 중간 보고서"
category: "CV/Projects"
comments: true
tags: [project, "CV"]
feature-img: "assets/img/72.jpg"
feature-title:
use_math: true
summary: "프로젝트 중간 점검과 진행 방향을 결정한다."
series: "Face Detection and Tracking with SSD Network"
---

# Introduction

얼굴 탐지 및 추적은 AR, VR등 뿐만 아니라 CCTV, 온라인 광고 판의 마케팅 지표로 사용될 만큼 중요하게 여겨지는 연구 주제이다. 하지만 여러 사람이 한 프레임 안에서 활동하고 있을 때, 가려짐을 해소할 수 없다는 문제가 여전히 남아있다. 또한 저가형 카메라와 같은 장비에서 위와 같은 기능을 하기 위해서 GPU를 사용할 수 없다는 단점이 존재한다. 따라서 아래의 연구에서는 CPU만을 통한 Object detection의 최적화를 통해 Face Tracking을 구현하는데 그 목적을 둔다.

# 논문 조사

## SORT(Simple Online and Realtime Tracking)

SORT(Simple Online and Realtime Tracking)은 매우 알고리즘이 간단함에도 불구하고 효과적이고 실용적인 다중 대상 추적 알고리즘이다. IOU를 기반으로 추적된 물체에 대해 association(할당)을 진행하기 때문에 매우 빠르다. 하지만 Id Switching(원래의 타겟을 잡지 못하고 다른 id를 배정하는 문제)가 여전히 많이 발생한다는 문제가 있다. IoU를 기반으로 매칭할 경우 여럿 문제점이 여전히 존재한다.

1. 물체가 빠르게 움직였을 경우 IoU는 작게 판단될 수 있다.
2. Occulusion(가려짐)이 발생했을 때 Detector가 Box를 작게 탐지했다면 IoU가 작게 나와 결과가 무시될 수 있다.

![DEEPSORT (2)](https://user-images.githubusercontent.com/37871541/111668333-fee74100-8858-11eb-93cc-586040420bc1.jpg){: .center }_DeepSort flowchart_



## DeepSort(SIMPLE ONLINE AND REALTIME TRACKING WITH A DEEP ASSOCIATION METRIC)

DeepSort는 이러한 Sort의 단점을 개선한 알고리즘으로 Cascade Matching 전략을 통해 이를 해결한다. 보행자 추적을 위해 구현된 이 알고리즘은 IoU이외에도 보행자를 기반으로 한 Feature Discriptor를 제작하여 정확도를 높혔다.

![DEEPSORT (2)](https://user-images.githubusercontent.com/37871541/111668333-fee74100-8858-11eb-93cc-586040420bc1.jpg){: .center }_DeepSort flowchart_



## ArcFace

ArcFace는 Face Recognition에 있어 triplet loss기반을 사용한 방법이다. Open set(얼굴에 대해 지도학습을 한 것이 아닌 embeding vector를 학습하기 위한 방법)으로, 데이터가 추가되더라도 reconition이 가능하다는 특징이 있다. alignment후 학습 시작

![image](https://user-images.githubusercontent.com/37871541/116079880-550a9800-a6d3-11eb-8b42-c293810aacb6.png){ .center }_Arcface architecture_



## MTCNN

MTCNN은 CNN을 활용하여 얼굴 검출 분야에서 정확도와 성능을 끌어올린 논문이다. Face Detection, Face Alignment, Bounding box regression 세가지 테스크를 동시에 학습시켜 각각의 시너지를 발휘하는 방법이다. 





# 연구 방향

실시간 Face Detector를 구현하기 위해서 필요한 것은 다음과 같다.

1. Face Detector
2. Feature Extractor
3. Deepsort 실시간으로 재구현


## Face Detector

<iframe width="660" height="360" src="https://www.youtube.com/embed/GZ2p2hj2H5k" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


CPU 기반 성능을 담보하기 위해 다양한 알고리즘을 검토한 결과 SSD network를 사용하였다. 하지만, 영상에서 보듯 속도는 빠르지만 Detection 성능에 있어서 깜빡깜빡하는 양상을 보인다. Deepsort 연구진들은 Detection 성능에 따라 Tracking 성능이 좌우된다고 말한바 있다. 따라서 이 부분에서 MTCNN으로 방향을 변경하였다.


하지만 MTCNN의 경우 사진 한장당 Inference time이 0.5초로 python으로 구현된 경우 상당히 느려 사용할 수 없었다. 이에 MTCNN을 C++ 구현을 통해 빌드하고, CPython을 사용하여 C++ 확장하여 Python에서 이를 호출하는 방식으로 구현 방향을 잡았다.


## Feature Extractor

Deepsort 논문에서 IoU 매칭의 대안으로 내놓은 Appearance Descriptor는 5개의 CNN 아키텍쳐를 기반으로 해당 patch(Detection이 된 객체)를 128차원의 Feature 공간으로 Embedding하는 것을 의미한다. 기존의 방법으로 Face Tracking을 해본 결과, image 공간이 제대로 추출되지 않아 쉬운 상황임에도 두개의 Track 물체가 잡힘을 확인할 수 있었다.


// 여기에 사진 들어가야 함 지금 상태로 돌렸을 때, 쉬운 상황임에도 두개의 물체가 잡히는 중



기존의 Sort 방법과 달리, 마할라노비스 거리를 Metric으로 사용하지 않았기 때문에(SORT 알고리즘에서 매칭을 할 때 사용한 Metric. Deepsort에서는 Appearance Descriptor만을 사용해도 결과가 잘 나와 값을 0으로 줌)이 Feature 가 굉장히 중요하다. 

이 부분에서 기존의 Face Recognition에서 사용하는 SOT 방법인 Arcface의 Model을 feature extraction에 사용한다. Arcface는 Open set에 대해 Face Recognition을 진행하는 방법으로 기본적으로 Metric Learning을 지향하는 방법이다. 저자들은 Additive Angular Margin Loss를 사용하여 기존의 Loss function보다 정확도를 높힘과 동시에 negligible computational overhead를 달성했다. 



## 실시간 구현


### Skip Frame

실시간 구현을 위해 모든 프레임을 사용하지 않고, 예측 프레임이 작은 정도를 예측한다면 이를 한번 Skip하는 방법이다. 추가적인 하이퍼 파라미터를 도입한다.



### 내부 구조 변화
현재 Deepsort는 정적 파일에 대해 Tracking을 진행하는 방식이다. 이를 실시간으로 변용하기 위해서는 기존의 파일을 변경해야 한다.

1. Opencv를 통한 Frame by Frame Load
2. MTCNN을 통한 Detection
3. Patching 후 Arcface Network를 통한 Feature Extraction
4. 2, 3의 결과를 묶은 numpy 배열 전달
5. Track 객체 생성 및 매칭
6. 실시간 화면 표시 및 fps 모니터링