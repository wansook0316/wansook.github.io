---
layout: post
title: "06: Writing Code"
category: "CV/Projects"
comments: true
tags: [project, "CV"]
feature-img: "assets/img/72.jpg"
feature-title:
use_math: true
summary: "설계대로 코드를 작한다."
series: "Face Detection and Tracking with SSD Network"
---

# Video_to_images.py

opencv를 통해 video data를 읽어 image로 변환하는 과정을 거쳤다. 이 때, 영상의 정보를 sequence.ini라는 파일에 저장하였다. 

<img width="202" alt="KakaoTalk_Photo_2021-04-18-18-37-33" src="https://user-images.githubusercontent.com/37871541/115141033-3540f780-a075-11eb-956d-951972be3abe.png">{: center=small}



<img width="255" alt="KakaoTalk_Photo_2021-04-16-11-07-21" src="https://user-images.githubusercontent.com/37871541/114961436-f871d680-9ea3-11eb-848a-24d52ea48eb4.png">{: .center-verysmall}




# Generate_detections.py

MTCNN을 통해 이미지들에서 얼굴을 찾았다. inference time이 장당 0.5초 나오기 때문에 다른 방법을 추후에 강구해야 할 것 같다. 당장은 일단 내가 원하는 영상에 대해서 tracking 함을 확인하는 것을 우선으로 한다.

이 부분에서는 box 처리외에도 feature를 추가로 붙여줘야 한다. 이 부분에서 tensorflow api를 사용하여 추출한다. 

Mobilenetv3를 사용했으며, 추후 다른 네트워크를 사용할 수 있도록 옵션을 만들 생각이다. 또한 기회가 된다면 사람 얼굴에 맞춘 Feature extractor를 custom으로 학습할 예정이다.


# Error 수정

sklearn 에 있는 linear_sum_assignment 함수의 output 모양이 변경되어 에러를 수정하였다. 

<img width="368" alt="KakaoTalk_Photo_2021-04-18-18-43-59" src="https://user-images.githubusercontent.com/37871541/115141225-0f682280-a076-11eb-93f2-4eae7555c18f.png">{: .center-small}




