---
layout: post
title: "01: 음원 재생기"
category: "DV/Swift"
comments: true
tags: [Swift, "Intermediate"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "음원 재생기를 제작해보자."
---

![image](https://user-images.githubusercontent.com/37871541/121643239-8e089b80-cacc-11eb-922e-1b16fd4663b4.png){. center}_project sample_


# 배울 내용

* Xcode 사용법
  * 프로젝트 생성 및 코드작성
  * 인터페이스 빌더를 활용한 UI 구성
  * 유용한 단축키
* UIKit 요소
  * UILabel
  * UIButton
  * UISlider
* 프레임워크
  * UIKit
  * AVFoundation
* 기술요소
  * Auto Layout
* Design Pattern
  * Model-View-Controller Pattern
* 기타 개념
  * IBOutlet, IBAction
  * Assets
  * Bundle
* Timer


# 단축키

* command + 0 : 네비게이터 영역 접기
* option + command + 0 : 유틸리티 영역 접기
* command 1~9 : 네이게이터 바의 영역 이동
* option click : 도움말



# Target

![image](https://user-images.githubusercontent.com/37871541/121644954-9d88e400-cace-11eb-95e3-77743eb9d872.png){. center}_하나의 프로젝트에 다수의 타겟이 있을 수 있다._

여기서 대상(Target)이란 iOS, macOS, tvOS, watchOS를 위한 애플리케이션과 같이 빌드할 제품을 말한다.




# Scheme

앱을 구동하기 전에, 어떤 타겟에 대한 환경을 설정할 것인지 정해줘야 한다. 위에서 말했듯 하나의 프롲게트에는 여러개의 Target이 존재할 수 있기 때문에, 각각의 target은 다른 환경 설정을 가질 수 있다. 그렇기 때문에 실제 앱이 구동되는 것을 보기 위해서는 내가 원하는 타겟과, 그에 맞는 설정파일(Scheme)을 선택해주어야 한다.

![image](https://user-images.githubusercontent.com/37871541/121645245-ee004180-cace-11eb-901b-0ae4b542c511.png){. center-verysmall}
![image](https://user-images.githubusercontent.com/37871541/121645530-433c5300-cacf-11eb-86f9-43131bec6fc6.png){. center-verysmall}_Scheme과 Target simulator_

이렇게 실행할 기기를 선택할 수 있다. 시뮬레이터를 사용하면 무료이지만, 기기에서 테스트를 무료로 하려면 일주일에 한번 빌드해줘야 한다. 유료는 그런 걱정이 없다.

WatchOS를 사용했다면 동시에 뜨는 시뮬레이터를 실행시킬 수 있다.

![image](https://user-images.githubusercontent.com/37871541/121645930-b8a82380-cacf-11eb-87d8-3e6747a78c60.png){. center-small}


