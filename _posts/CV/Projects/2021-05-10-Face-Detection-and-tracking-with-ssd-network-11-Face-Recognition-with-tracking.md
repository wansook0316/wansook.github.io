---
layout: post
title: "11: Face Recognition with Tracking"
category: "CV/Projects"
comments: true
tags: [project, "CV"]
feature-img: "assets/img/72.jpg"
feature-title:
use_math: true
summary: "기존의 Deepsort를 발전시켜, Face Recognition을 도입하고, 평가한다."
series: "Face Detection and Tracking with SSD Network"
---

# Face Recognition

![DEEPSORT](https://user-images.githubusercontent.com/37871541/118685421-079aca00-b83e-11eb-8854-11c0abd854cf.jpg){: .center}

기존의 Face Tracking 알고리즘에 비해 높은 성능을 기대하기 위해 기존 Deep sort 저자들이 사용한 Feature Extraction Network를 Arcface로 변환하였다. 이 때, 현재 보이는 프레임에서 인식하고 싶은 사용자가 있을 경우, 이를 실시간으로 탐지할 수 있도록 Face DB를 구축하여 Matching이 된 Track과 새롭게 생성이 된 Track에 이를 반영하였다.

![DEEPSORT_with_Arcface](https://user-images.githubusercontent.com/37871541/117641745-7b473200-b1c1-11eb-95aa-d210c4e3e2e7.jpg){: .center}

순서는 다음과 같다.

1. Tracking을 진행하고 싶은 사람의 이미지로 부터 Arcface를 통해 Feature Extraction을 진행하고, 이를 해시맵에 저장한다.
2. 비디오를 동작시킨다.
    1. 프레임을 Yolov3에 통과시켜, 해당 이미지안에 존재하는 얼굴을 탐지한다.
    2. 탐지된 얼굴을 Matching Cascade 구조에 집어 넣는다.
        * 이 때, 탐지된 얼굴의 Feature Extraction을 할 때 Arcface를 사용하여 512차원 벡터를 추출한다.
    3. Unmatched Track, Matched Track, Unmatched Detection으로 분리된 결과를 얻는다.
    4. 먼저 Matched Track에 대해 Face DB에 있는 Feature 정보와 Track내에 존재하는 이전의 Frame에 대한 정보를  Cosine Similarity를 적용하여 유사도를 검증한다.
    5. 각각의 얼굴 정보에 대해 Cosine Similarity가 가장 작은 얼굴을 후보로 구성한다.
    6. 후보로 선택된 얼굴의 Score가 Threshold(0.681)보다 작을 경우 해당 객체의 얼굴 id로 적용한다.
    7. 다음으로 새롭게 생성된 Track에 대해 같은 작업을 반복한다. 이 때, 이미 배정된 얼굴의 경우 선택되지 않는다.

# 작동 및 결과

Recall과 precision같은 경우 기존 Tracking 연구보다 높은 수준을 보였으나, MOTA (추적 정확도) 측면에서 나쁜 점수가 나왔다. 이는 각각의 프레임에서 추가적인 얼굴 탐지 때문에 FN가 크게 올라서 점수를 낮게 만든 것이라 판단한다.

![image](https://user-images.githubusercontent.com/37871541/119105685-89663f80-ba58-11eb-89fe-6c29e5f9d4c6.png)


## T-ara

|IDF1|IDP|IDR|Rcll|Prcn|FP|FN|IDs|FM|MOTA|MOTP|FAR|Fn|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|53.6%|59.0%|49.5%|76.6%|90.4%|1176|3406|3752|517|42.6%|71%|0.241|4710|

## GirlsAloud

|IDF1|IDP|IDR|Rcll|Prcn|FP|FN|IDs|FM|MOTA|MOTP|FAR|Fn|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|39.0%|42.6%|36.4%|73.9%|85.3%|2087|4275|4687|1122|32.6%|64.6%|0.314|6630|

## Darling

|IDF1|IDP|IDR|Rcll|Prcn|FP|FN|IDs|FM|MOTA|MOTP|FAR|Fn|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|3.2%|44.2%|42.6%|79.7%|82.1%|1654|1935|3048|743|30.4%|65.7%|0.267|6180|

## Westlife

|IDF1|IDP|IDR|Rcll|Prcn|FP|FN|IDs|FM|MOTA|MOTP|FAR|Fn|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|64.3%|61.3%|68.4%|87.8%|77.9%|2828|1389|1809|562|47.0%|64.7%|0.411|6870|

## BrunoMars

|IDF1|IDP|IDR|Rcll|Prcn|FP|FN|IDs|FM|MOTA|MOTP|FAR|Fn|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|40.5%|40.7%|40.8%|74.1%|73.1%|4560|4330|5128|1010|16.1%|78.9%|0.539|8460|

## HelloBubble

|IDF1|IDP|IDR|Rcll|Prcn|FP|FN|IDs|FM|MOTA|MOTP|FAR|Fn|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|41.9%|45.3%|39.1%|73.9%|85.2%| 673|1363|1381|301|34.6%|69.7%|0.256|4920|

## Apink

|IDF1|IDP|IDR|Rcll|Prcn|FP|FN|IDs|FM|MOTA|MOTP|FAR|Fn|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|56.2% | 58.9% | 53.8% |79.5% |86.8% |  883| 1491| 1234 | 337 |50.4% | 66.8% | 0.15 |4650|

<!-- 
T-ara
    IDF1    IDP    IDR  Rcll  Prcn GT MT PT ML   FP   FN  IDs   FM  MOTA  MOTP  IDt IDa IDm
0  53.6%  59.0%  49.5% 76.6% 90.4%  6  3  3  0 1176 3406 3752  517 42.6% 0.285 2994   4   4
1 108.3% 100.0% 100.0% 76.6% 90.4%  6  3  3  0 1176 3406 3752  517 42.6% 0.285 2994   4   4

GirlsAloud
    IDF1    IDP    IDR  Rcll  Prcn GT MT PT ML   FP   FN  IDs    FM  MOTA  MOTP  IDt IDa IDm
0  39.0%  42.6%  36.4% 73.9% 85.3%  5  0  5  0 2087 4275 4687  1122 32.6% 0.354 3886   3   3
1 107.2% 100.0% 100.0% 73.9% 85.3%  5  0  5  0 2087 4275 4687  1122 32.6% 0.354 3886   3   3
Darling
    IDF1    IDP    IDR  Rcll  Prcn GT MT PT ML   FP   FN  IDs   FM  MOTA  MOTP  IDt IDa IDm
0  43.2%  44.2%  42.6% 79.7% 82.1%  8  4  4  0 1654 1935 3048  743 30.4% 0.343 2347   6   6
1 101.5% 100.0% 100.0% 79.7% 82.1%  8  4  4  0 1654 1935 3048  743 30.4% 0.343 2347   6   6
Westlife
   IDF1    IDP    IDR  Rcll  Prcn GT MT PT ML   FP   FN  IDs   FM  MOTA  MOTP  IDt IDa IDm
0 64.3%  61.3%  68.4% 87.8% 77.9%  4  4  0  0 2828 1389 1809  562 47.0% 0.353 1435   2   2
1 94.1% 100.0% 100.0% 87.8% 77.9%  4  4  0  0 2828 1389 1809  562 47.0% 0.353 1435   2   2
BrunoMars
   IDF1    IDP    IDR  Rcll  Prcn GT MT PT ML   FP   FN  IDs    FM  MOTA  MOTP  IDt IDa IDm
0 40.5%  40.7%  40.8% 74.1% 73.1% 11  3  8  0 4560 4330 5128  1010 16.1% 0.319 3570   9   9
1 99.3% 100.0% 100.0% 74.1% 73.1% 11  3  8  0 4560 4330 5128  1010 16.1% 0.319 3570   9   9

HelloBubble
    IDF1    IDP    IDR  Rcll  Prcn GT MT PT ML  FP   FN  IDs   FM  MOTA  MOTP  IDt IDa IDm
0  41.9%  45.3%  39.1% 73.9% 85.2%  4  0  4  0 673 1363 1381  301 34.6% 0.313 1009   3   3
1 107.1% 100.0% 100.0% 73.9% 85.2%  4  0  4  0 673 1363 1381  301 34.6% 0.313 1009   3   3


Apink

    IDF1    IDP    IDR  Rcll  Prcn GT MT PT ML  FP   FN  IDs   FM  MOTA  MOTP IDt IDa IDm
0  56.2%  58.9%  53.8% 79.5% 86.8%  6  3  3  0 883 1491 1234  337 50.4% 0.332 709   5   5
1 104.4% 100.0% 100.0% 79.5% 86.8%  6  3  3  0 883 1491 1234  337 50.4% 0.332 709   5   5 -->

