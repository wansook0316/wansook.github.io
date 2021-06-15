---
layout: post
title: "10: Arcface"
category: "CV/Projects"
comments: true
tags: [project, "CV"]
feature-img: "assets/img/72.jpg"
feature-title:
use_math: true
summary: "프로젝트 중간 점검과 진행 방향을 결정한다."
series: "Face Detection and Tracking with SSD Network"
---

# Feature Apperance Model 변경


![DEEPSORT (2)](https://user-images.githubusercontent.com/37871541/111668333-fee74100-8858-11eb-93cc-586040420bc1.jpg){: .center }_DeepSort flowchart_

물체 추적을 담당하는 Deepsort의 구조는 위와 같다. 새롭게 탐지된 객체들의 매칭을 수행하기 위해 Matching Cascade라는 방법을 사용한다. 가장 적합한 객체와 새롭게 탐지된 객체를 매칭하기 위해서는 이를 표현할 Metric이 필요하다. 위 논문에서는 다음과 같은 Feature Appearance Model을 사용하여 해당 그림를 표현하는 128차원 벡터를 추출한다.

![image](https://user-images.githubusercontent.com/37871541/117616181-be93a780-b1a5-11eb-86dd-69a9d97d29a0.png){: .center-small}

![image](https://user-images.githubusercontent.com/37871541/117616257-d539fe80-b1a5-11eb-9ae0-cdba5b50effa.png){: .center-small}

2개의 Conv layer와 Residual 네트워크를 사용하여 128차원 Vector를 추출하였다. 하지만 기본적으로 Deep sort는 보행자를 구분하기 위해 제작된 바, 입력의 크기가 128x64로 세로로 긴 직사각형의 형태를 띈다. 이는 현재 제작하려는 Face Tracker에 문제가 되는 부분이다. 얼굴의 형태는 보행자의 모양처럼 2:1의 aspect ratio를 가지지 않는다. 1:1에 비율에 맞는 input size에 대해 Feature extraction을 하는 것이 보다 이 과제에 적합한 방향이다. 


## Arcface

Arcface는 Face Recognition을 위해 제작된 Feature Extractor이다. Resnet34를 backborn으로 사용하고, 이를 기반으로 Additive Angular Margin Penalty 기반으로 학습을 진행하여 512차원의 벡터를 추출한다. 

![image](https://user-images.githubusercontent.com/37871541/117617147-14b51a80-b1a7-11eb-8c1f-e82c280fb479.png){: .center-verysmall}

이러한 방법을 사용했을 때, 기본 Softmax를 사용했을 때 보다 각각의 id를 구분하는 Feature가 생성된다고 한다. 얼굴의 특징을 추출하고, 이를 구분하기 위해서는 보다 정확한 feature extractor가 필요하다고 판단, 현재 구성된 보행자 기반 모델을 이를 사용하여 대체하는 작업을 진행했다.



![DEEPSORT_with_Arcface](https://user-images.githubusercontent.com/37871541/117641745-7b473200-b1c1-11eb-95aa-d210c4e3e2e7.jpg){: .center}

순서는 다음과 같다.

1. 정적인 파일로 존재하는 사진으로 부터 파일을 읽는다.
2. 이를 Yolov3를 통과하여 얼굴을 탐지한다.
3. 탐지된 Detection box를 기반으로 이미지를 patching한다.
4. patching된 이미지를 바탕으로 Arcface를 통해 Feature Extraction을 진행한다.
5. 이를 지정된 얼굴의 이름을 기반으로 Key-map 구조로 가지고 있는다.
6. Track 객체가 생성될 때, Feature를 이미지의 Feature와의 Cosine 값을 구한다.
7. 이 값들 중 가장 작은 값(이전 프레임으로부터 생성된 Feature들과 이미지 Feature가 가지는 가장 작은 값 = 넣은 input이미지와 가장 비슷했을 때 유사도)을 추출한다.
8. 7번의 값이 일정 threshold보다 작을 경우 face_name을 추가한다. 




# 작동

![image](https://user-images.githubusercontent.com/37871541/117655512-206a0680-b1d2-11eb-91ba-c1ed9b758ae5.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/117655539-28c24180-b1d2-11eb-8ef9-98b216cfea13.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/117655571-337cd680-b1d2-11eb-99d5-41e380ab81c1.png){: .center}

<img width="788" alt="KakaoTalk_Photo_2021-05-10-21-00-33" src="https://user-images.githubusercontent.com/37871541/117656024-c7e73900-b1d2-11eb-87d5-9376826da7dd.png">{: .center}



하지만 잘 작동이 되지 않았다. 다른 Track 객체가 생성되었을 때, cosine 유사도를 검증했을 때, 대부분 0.3근처의 값이 도출되었다. 두 가지 문제라 생각할 수 있다. 1) Metric을 매칭하는 방법이 잘못되었다, 2) 객체가 생성될 때 face_name을 매칭하는 것이 오류를 부르는 방법이다. 추가로 이러한 방향을 테스트하여 Identification이 되는 Tracker를 제작한다.

# 오류 해결 추가 방향

1. Track 객체가 생성될 때 비교하지 말고, Matching이 되었을 때 비교한다.
2. Cosine metric이 가장 작을 때가 아닌 다른 metric을 사용하여 face_name을 매핑한다.
3. 다른 영상에도 적용하여 결과를 파악한다.