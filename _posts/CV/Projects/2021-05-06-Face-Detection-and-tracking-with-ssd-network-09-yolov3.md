---
layout: post
title: "09: Yolov3 사용"
category: "CV/Projects"
comments: true
tags: [project, "CV"]
feature-img: "assets/img/72.jpg"
feature-title:
use_math: true
summary: "프로젝트 중간 점검과 진행 방향을 결정한다."
series: "Face Detection and Tracking with SSD Network"
---

# C++ 포기

MTCNN을 기반으로 C++ 빌드 후 Python에 얹어서 쓰는 방향을 고안했으나, 실질적으로 이를 구현하는데 실패했다. 


# Yolo v3 사용

GPU 장비를 통해 Yolov3를 통해 실시간 조건을 만족시키기로 했다. 먼저, [yolov3-tf2](https://github.com/zzh8829/yolov3-tf2) 를 기반으로 테스트를 수행했다. 수행한 환경은 다음과 같다.

* Cuda 11.0
* cudnn 8.0.5
* tensorflow 2.4.1
* opencv 최신 버전
* python 3.7




## Realtime 구조 변경

기존의 Deepsort는 static구조로 작동하기 때문에, 이를 dynamic하게 변경할 필요가 있었다. 이를 기반으로 먼저, 작동하는 yolov3 모델을 기반으로 실시간 tracking이 가능하도록 코드를 수정했다.



<img width="829" alt="스크린샷 2021-05-06 오후 5 58 20" src="https://user-images.githubusercontent.com/37871541/117270917-a74a7680-ae94-11eb-878d-2a4257995f0e.png">{: .center}



# Widerface Dataset Training

기본적으로 Yolov3는 object detection api 기반으로 훈련한다. 그렇기 때문에, 이를 훈련하기 위해서는 데이터 셋을 이에 맞는 tfrecords 형태로 변환할 필요가 있다. [using_your_own_dataset](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/using_your_own_dataset.md)을 기반으로 widerface dataset을 tfrecords로 변경했다.

1. widerface 다운로드
2. widerface file structure를 pascalvoc style로 변경
3. pascalvoc를 기반으로 tfrecords 생성
4. Yolov3 training

16000번 훈련을 진행했고, 나쁘지 않은 val_loss를 보여주었다. 

# Face Tracking

![image](https://user-images.githubusercontent.com/37871541/117247050-92f88080-ae78-11eb-9840-74b3627c57f7.png){. center}

gpu를 사용했음에도 불구하고, tracking되는 물체가 여러개일 경우, Tracking 알고리즘이 동작하는 속도가 많이 느려진다.(10개 대비 10배 정도 차이나는 것으로 확인됨.)

![image](https://user-images.githubusercontent.com/37871541/117247129-b58a9980-ae78-11eb-8a9d-560f6fe02b6d.png){. center}

기존에 위의 영상에서 MTCNN을 사용한 결과, 대부분의 인물을 탐지하는 모습을 보였었다. 이를 훈련한 Yolov3 모델의 결과로 사용해보니, 위와 같이 모두 잡는 모습을 보였다. 정확도가 올라가 Tracking도 무리 없이 진행하고 있다. 10개 남짓한 Tracking object를 관리할 경우에는 20fps를 달성하고 있다.



![image](https://user-images.githubusercontent.com/37871541/117247430-2df15a80-ae79-11eb-8af5-debfc6b9ab6f.png){. center}
![image](https://user-images.githubusercontent.com/37871541/117247452-35186880-ae79-11eb-8d3d-f5275b54d17c.png){. center}

먼저, 이렇게 작은 얼굴에 대해서도 잘 탐지하는 모습을 보인다. 기존 MTCNN으로는 잡지 못했던 결과물이다. 
![image](https://user-images.githubusercontent.com/37871541/117247461-3b0e4980-ae79-11eb-96cc-eef6dd2123b4.png){. center}

하지만 이렇게 프레임이 전환된 이후에 이전 객체를 다시 잡지 못하는 문제가 발생한다. 이는 Track 객체의 생애주기가 30frame으로 고정되어 있기 때문이다. frame이 끊겨 기존 물체가 사라짐에도 불구하고 계속해서 인물을 tracking하는 방법을 찾아야 한다.


# 추후 방향

Arcface를 사용하여 face Recognition을 진행할 수 있도록 변경한다. 이를 위해서는 인물 database를 구축하는 방법을 사용해야 할 것으로 보인다. 이 인물 database에 없는 인물 같은 경우는 tracking은 하되, id 유지는 하지 않도록 한다.
