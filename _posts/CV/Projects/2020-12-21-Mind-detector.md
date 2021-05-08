---
layout: post
title: "마음을 읽는 AI 우울감 자가진단 서비스, 마인드디텍터"
category: "CV/Projects"
comments: true
tags: [project, "CV"]
feature-img: "assets/img/43.jpg"
feature-title:
use_math: true
summary: 
series: "MindDetector"
---

> Google NMT api와 kobert를 사용하여 감성 분석을 진행하고, 서비스에 탑재하였다.

- 2020.12(1개월)
- Open api, pytorch, Flask
- 자연어 처리 모델 기반 우울감 자가진단 서비스 "마인드디텍터" 웹 어플리케이션 제작 프로젝트
- SKT에서 개발한 Kobert를 기반으로 Naver 영화 감정 분석 데이터셋과 짧은 감정 분류를 위한 데이터셋(영문)을 통해 모델 미세 조정
- 영문 데이터의 경우 Google transform api를 통해 번역 후 학습에 사용
- 우울 지수를 계산하기 위해 공공 데이터 포털에서 자살률과 감정 예측 결과를 조합하여 사용
- 최종적으로 서비스를 위해 flask 서버를 띄우고 요청의 대한 결과로 결과 응답
- 정부혁신제안 끝장개발대회 메이커톤 최우수상


[마음을 읽는 AI 우울감 자가진단 서비스, 마인드디텍터](http://minddetector.me/)  
[server github](https://github.com/sarah5398/mind-detector)  
[emotion analysis github](https://github.com/wansook0316/emotion_analysis_)  


![f9180a50826347d9ad4db726f6d58a74NgzvkNaAgUePc86E-0](https://user-images.githubusercontent.com/37871541/102734570-810fb880-4383-11eb-9bff-bb8a403cb7ac.jpg){: .center width="100%"}
![f9180a50826347d9ad4db726f6d58a74NgzvkNaAgUePc86E-1](https://user-images.githubusercontent.com/37871541/102734578-866d0300-4383-11eb-9651-0711e280ed24.jpg){: .center width="100%"}
![f9180a50826347d9ad4db726f6d58a74NgzvkNaAgUePc86E-2](https://user-images.githubusercontent.com/37871541/102734580-87059980-4383-11eb-9862-96d4d651f0f9.jpg){: .center width="100%"}
![f9180a50826347d9ad4db726f6d58a74NgzvkNaAgUePc86E-3](https://user-images.githubusercontent.com/37871541/102734584-879e3000-4383-11eb-9d70-810cded6864f.jpg){: .center width="100%"}
![f9180a50826347d9ad4db726f6d58a74NgzvkNaAgUePc86E-4](https://user-images.githubusercontent.com/37871541/102734585-8836c680-4383-11eb-9339-45c0edbc744d.jpg){: .center width="100%"}
![f9180a50826347d9ad4db726f6d58a74NgzvkNaAgUePc86E-5](https://user-images.githubusercontent.com/37871541/102734588-88cf5d00-4383-11eb-9631-0a2ba0584790.jpg){: .center width="100%"}
![f9180a50826347d9ad4db726f6d58a74NgzvkNaAgUePc86E-6](https://user-images.githubusercontent.com/37871541/102734590-88cf5d00-4383-11eb-9f8e-0cfb4a7266ab.jpg){: .center width="100%"}
