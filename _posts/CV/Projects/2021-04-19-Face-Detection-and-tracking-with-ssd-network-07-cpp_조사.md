---
layout: post
title: "07: 중간 점검 및 추후 방향성 검토"
category: "CV/Projects"
comments: true
tags: [project, "CV"]
feature-img: "assets/img/72.jpg"
feature-title:
use_math: true
summary: "추후 방향성을 정립한다."
series: "Face Detection and Tracking with SSD Network"
---
# 동작 확인
```

```

<img width="748" alt="KakaoTalk_Photo_2021-04-23-13-11-49" src="https://user-images.githubusercontent.com/37871541/115817337-9da52580-a435-11eb-9863-8df910c092b7.png">{: .center-small }
<img width="748" alt="KakaoTalk_Photo_2021-04-23-13-11-55" src="https://user-images.githubusercontent.com/37871541/115817339-9ed65280-a435-11eb-9a27-82d583bf3271.png">{: .center-small }
<img width="747" alt="KakaoTalk_Photo_2021-04-23-13-12-01" src="https://user-images.githubusercontent.com/37871541/115817343-a138ac80-a435-11eb-8f30-e4a23a53f49a.png">{: .center-small }
<img width="746" alt="KakaoTalk_Photo_2021-04-23-13-12-06" src="https://user-images.githubusercontent.com/37871541/115817345-a3027000-a435-11eb-9afa-b979b9b53166.png">{: .center-small }
<img width="754" alt="KakaoTalk_Photo_2021-04-23-13-12-14" src="https://user-images.githubusercontent.com/37871541/115817353-a695f700-a435-11eb-9e8e-57932cdf2ebc.png">{: .center-small }
<img width="744" alt="KakaoTalk_Photo_2021-04-23-13-12-20" src="https://user-images.githubusercontent.com/37871541/115817356-a85fba80-a435-11eb-8cfe-bea0660d927b.png">{: .center-small }



## 문제점

* Input video에 대해 detection 결과를 이끌어내는 과정까지가 너무 오래걸린다.
  * MTCNN 사용시 1장 당 inference 약 0.5초
  * detection 결과를 기반으로 feature extraction 시간 역시 소요
* 보행자와 달리 얼굴을 여러 각도로 돌리기 때문에 Feature를 좀더 명확하게 뽑을 필요가 있다.
* 또한 가려짐 효과를 적용하기 위한 Track 객체의 생애주기를 늘려야 할 필요가 있다.


## 해결 방안 탐색

* MTCNN 말고 다른 네트워크를 사용한다.
  * inference 시간이 더 필요하다. gpu는 사용하고 싶지 않다.
* C로 구현된 것을 찾아본다.
  * 가장 좋은 판단이다.
  * ncnn을 기반으로 구현된 오픈 소스가 있다.[MTCNN-NCNN](https://github.com/LicheeX/MTCNN-NCNN)

# 추후 구현 방안
> 목표 : 실시간으로 돌아가는 face tracker를 제작한다.

1. Feature extraction cbtxt로 저장, 후 로드 이해
   1. 저장이 된다면 저장한 후에 로드해서 돌려보기
   2. 저장이 안되면.. 모르겠다 일단.
2. 지금 face detection 만들 파일로 C++ 딥소트 돌려보기
   1. 문제가 발생한다 -> MTCNN만 돌려서 python 기반 실시간 구현으로 방향 전환
   2. 잘 된다. -> 소스코드를 뜯어서 이미지 한장 단위로 들어갈 수 있는지 확인한다.
      1. 한장 단위로 inference가 불가능하다. -> Python으로 간다.
      2. 한장단위로 가능하다. c++ 시도

6월 이전 완성을 고려하면, MTCNN만 C++로 변경한 뒤, 실시간 방법을 고민하는 것이 현실적이다.


* Detection 속도를 줄이기 위해, C++ 기반 딥러닝 아키텍쳐인 ncnn을 기반으로 MTCNN 결과를 추출한다.
* 이후 Python에서 c++ 함수를 사용할 수 있도록 조치한다.
* Feature Extraction을 가중치 파일로 변환한다.
* 실시간 로직을 짠다.
* 추가로 정확도를 높히기 위해 Model을 훈련하여 저장해둔다.
* Inference time 체크하여 실시간인지 확인한다.
