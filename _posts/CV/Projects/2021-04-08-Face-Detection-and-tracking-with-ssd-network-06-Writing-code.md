---
layout: post
title: "06: Writing Code"
category: "CV/Projects"
comments: true
tags: [project, "CV"]
feature-img: "assets/img/72.jpg"
feature-title:
use_math: true
summary: "설계대로 코드를 작성한다."
series: "Face Detection and Tracking with SSD Network"
---

# Video_to_images.py

opencv를 통해 video data를 읽어 image로 변환하는 과정을 거쳤다. 이 때, 영상의 정보를 sequence.ini라는 파일에 저장하였다. 

파일 구조 사진

ini 파일 내용 사진





# Genenrate_detections.py

MTCNN을 통해 이미지들에서 얼굴을 찾았다. inference time이 장당 0.5초 나오기 때문에 다른 방법을 추후에 강구해야 할 것 같다. 당장은 일단 내가 원하는 영상에 대해서 tracking 함을 확인하는 것을 우선으로 한다.

이 부분에서는 box 처리외에도 feature를 추가로 붙여줘야 한다. 이 부분에서 tensorflow api를 사용하여 추출한다. 


