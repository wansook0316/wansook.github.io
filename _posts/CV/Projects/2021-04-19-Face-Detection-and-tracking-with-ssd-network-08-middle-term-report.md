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

SORT(Simple Online and Realtime Tracking)은 매우 알고리즘이 간단함에도 불구하고 효과적이고 실용적인 다중 대상 추적 알고리즘이다. IOU를 기반으로 추적된 물체에 대해 association(할당)을 진행하기 때문에 매우 빠르다. 하지만 Id Switching(원래의 타겟을 잡지 못하고 다른 id를 배정하는 문제)가 여전히 많이 발생한다는 문제가 있다. 그 원인으로는 아래의 요인이 있다.

1. 물체가 빠르게 움직였을 경우 IoU는 작게 판단될 수 있다.
2. Occulusion(가려짐)이 발생했을 때 Detector가 Box를 작게 탐지했다면 IoU가 작게 나와 결과가 무시될 수 있다.

![Untitled Diagram](https://user-images.githubusercontent.com/37871541/111637945-3942e500-883d-11eb-962d-23aaadf57d6a.jpg){: .center }_SORT flowchart_


## DeepSort(Simple Online and Realtime Tracking with A Deep association metric)

DeepSort는 이러한 SORT의 단점을 개선한 알고리즘으로 Cascade Matching 전략을 통해 이를 해결한다. 보행자 추적을 위해 구현된 이 알고리즘은 IoU이외에도 보행자를 기반으로 한 Feature Discriptor를 제작하여 정확도를 높혔다. 칼만 필터로 예측한 Track에 담겨 있는 이전 프레임의 외형 정보(128dim feature)를 기반으로 현재 탐지된 객체와의 유사도를 검증한다. 이 때 두 객체의유사도를 판단하는데 있어 Cosine similarity를 사용하며, 최종 매칭은 헝가리안 알고리즘을 사용한다. Track 객체를 삭제하는데 있어서 생애주기라는 개념을 도입한다.

![DEEPSORT (2)](https://user-images.githubusercontent.com/37871541/111668333-fee74100-8858-11eb-93cc-586040420bc1.jpg){: .center }_DeepSort flowchart_



## ArcFace

ArcFace는 Face Recognition에 있어 triplet loss기반을 사용한 방법이다. Open set(얼굴에 대해 지도학습을 한 것이 아닌 embeding vector를 학습하기 위한 방법)으로, 데이터가 추가되더라도 reconition이 가능하다는 특징이 있다. 

![image](https://user-images.githubusercontent.com/37871541/116079880-550a9800-a6d3-11eb-8b42-c293810aacb6.png){ .center }_Arcface architecture_



## MTCNN

MTCNN은 CNN을 활용하여 얼굴 검출 분야에서 정확도와 성능을 끌어올린 논문이다. Face Detection, Face Alignment, Bounding box regression 세가지 테스크를 동시에 학습시켜 각각의 시너지를 발휘하는 방법이다. 

![image](https://user-images.githubusercontent.com/37871541/116232735-79c74400-a795-11eb-8655-3646863c6b5f.png){ .center }_MTCNN architecture_





# 연구 방향

실시간 Face Detector를 구현하기 위해서 필요한 것은 다음과 같다.

1. Face Detector
2. Feature Extractor
3. Deepsort 재구현 및 기여 방안


## Face Detector

<iframe width="660" height="360" src="https://www.youtube.com/embed/GZ2p2hj2H5k" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


CPU 기반 성능을 담보하기 위해 다양한 알고리즘을 검토한 결과 SSD network를 사용하였다. 하지만, 영상에서 보듯 속도는 빠르지만 Detection 성능에 있어서 깜빡깜빡하는 양상을 보인다. Deepsort 연구진들은 Detection 성능에 따라 Tracking 성능이 좌우된다고 말한바 있다. 따라서 이 부분에서 MTCNN으로 방향을 변경하였다.


하지만 MTCNN의 경우 사진 한장당 Inference time이 0.5초로 python으로 구현된 경우 상당히 느려 사용할 수 없었다. 이에 MTCNN을 C++ 구현을 통해 빌드하고, CPython을 사용하여 C++ 확장하여 Python에서 이를 호출하는 방식으로 구현 방향을 잡았다.


## Feature Extractor

Deepsort 논문에서 IoU 매칭의 대안으로 내놓은 Appearance Descriptor는 5개의 CNN 아키텍쳐를 기반으로 해당 patch(Detection이 된 객체)를 128차원의 Feature 공간으로 Embedding하는 것을 의미한다. 기존의 방법으로 Face Tracking을 해본 결과, image 공간이 제대로 추출되지 않아 쉬운 상황임에도 같은 Track 물체가 잡힘을 확인할 수 있었다.


![KakaoTalk_Photo_2021-04-30-15-20-11](https://user-images.githubusercontent.com/37871541/116656908-75cf3800-a9c8-11eb-8f4f-03738054662d.png){: .center}
![KakaoTalk_Photo_2021-04-30-15-20-06](https://user-images.githubusercontent.com/37871541/116656916-7962bf00-a9c8-11eb-9504-036446a5c57e.png){: .center}
![KakaoTalk_Photo_2021-04-30-15-20-01](https://user-images.githubusercontent.com/37871541/116656919-7a93ec00-a9c8-11eb-8ab7-6f7365496817.png){: .center}




기존의 Sort 방법과 달리, 마할라노비스 거리를 Metric으로 사용하지 않았기 때문에(SORT 알고리즘에서 매칭을 할 때 사용한 Metric. Deepsort에서는 Appearance Descriptor만을 사용해도 결과가 잘 나와 값을 0으로 줌)이 Feature 가 굉장히 중요하다. 

이 부분에서 기존의 Face Recognition에서 사용하는 SOT 방법인 Arcface의 Model을 feature extraction에 사용한다. Arcface는 Open set에 대해 Face Recognition을 진행하는 방법으로 기본적으로 Metric Learning을 지향하는 방법이다. 저자들은 Additive Angular Margin Loss를 사용하여 기존의 Loss function보다 정확도를 높힘과 동시에 negligible computational overhead를 달성했다. 



## Deepsort 재구현 및 기여 방안



### 생애주기 변경

기존 Deepsort에서 물체를 탐지하지 못한 경우 30Frame이 지날 경우 삭제하고 새로운 id를 부여했다. 하지만 이 주기가 너무 짧아 얼굴이 등장하는 영상에서 지속적으로 탐색을 실패하는 경향을 보였다. 하지만 생애주기를 지나치게 길게 잡을 경우, 하나의 Detection에 대해 여러개의 Track객체가 형성될 수 있어 공간적, 의미론적으로 옳지 않은 결과가 도출된다. 따라서 이 생애주기의 최적점을 선정하고, Track이 지나치게 많아지지 않는 방법을 반영한다.


### 내부 구조 변화
현재 Deepsort는 정적 파일에 대해 Tracking을 진행하는 방식이다. 이를 실시간으로 변용하기 위해서는 기존의 파일을 변경해야 한다.

1. Opencv를 통한 Frame by Frame Load
2. MTCNN을 통한 Detection
3. Patching 후 Arcface Network를 통한 Feature Extraction
4. 2, 3의 결과를 묶은 numpy 배열 전달
5. Track 객체 생성 및 매칭
6. 실시간 화면 표시 및 fps 모니터링



# 최종 제안 방향

[실시간 구현](https://www.youtube.com/watch?v=zi-62z-3c4U)

> Skip frame 방법과 Face Metric Learning을 통한 Realtime Face Tracker 제작

최종적으로 본 연구에서는 Skip frame 방법을 통해 실시간 Face Tracking 방법을 제안하며, 이 때 SOT의 Face Recognition Network인 Arcface를 통해 학습된 weight를 통해 Feature extration을 진행한다.