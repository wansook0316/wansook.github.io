---
layout: post
title: "02: 음원 재생기 - 02"
category: "DV/Swift"
comments: true
tags: [iOS]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "음원 재생기를 제작해보자."
---

# UIButton

* 메서드 연결 방법
  * 일단은 IBAction만 사용해보자
* 버튼의 상태
  * default
  * highlighted
  * focused
  * selected
  * disabled
  * 그리고 이 상태는 조합이 가능하다.
  * 기본은 default
* property
  * 코드 혹은 스토리 보드로


# UISlider

* 용어
  * 최소 : Minimum Image
  * 최대 : Maximum Image
  * 이동하는 버튼 : Thumb
  * 줄 : Track


# AVFoundation

다양한 Apple 플랫폼에서 사운드 및 영상 미디어의 처리, 제어 , 가져오기 및 내보내기 등 관범위한 기능을 제공하는 프레임워크이다.

* 주요 기능
  * 미디어 재생 및 편집
    * QuickTime 동영상, MPEG-4 파일 재생, 생성, 편집
    * HLS 스트림 재생 [재생 가능 파일 목록](https://developer.apple.com/documentation/avfoundation/avfiletype)
    * 디바이스 카메라와 마이크를 이용한 영상 녹화 및 사운드 녹음
    * 시스템 사운드 제어
    * 문자의 음성화 (?)
  * AVAudioPlayer Class
    * 이번엔 이거 사용할 것이다. 파일 및 메모리에 있는 사운드 데이터를 재생해 볼 것
    * 주요 기능
      * 파일 및 메모리에 있는 사운드 재생(네트워크 파일 재생 불가)
      * 파일 재생 시간 길이의 제한 없이 사운드 재생 (?)
      * 여러개 사운드 동시 재생
      * 재생 속도 제어 및 스테레오 포지셔닝
      * 앞으로 감기, 뒤로 감기
      * 현재 재생 정보 데이터 얻기
      * 반복 재생

어차피 자세한 것은 doc 찾아야 한다.


# Timer

일정 시간 간격이 지나면 지정된 메시지를 특정 객체로 전달한다.

* 특징
  * 런 루프에서 작동한다. (?)
    * RunLoop 객체는 소켓, 파일, 키보드 마우스 등의 입력 소스를 처리하는 이벤트 처리 루프로,쓰레드가 일해야 할 때는 일하고, 일이 없으면 쉬도록 하는 목적으로 고안되었다. RunLoop 입장에서 Timer는 입력이 아닌 특수한 유형이지만, Timer의 이벤트 또한 처리한다.
    * 즉 입력 소스에 대한 이벤트 루프라 하는 것 같다. 특이하게 얘는 여기서 처리한다.
    * 심화한 내용은 나중에.. 알아보도록 하자.
  * 반복 여부를 지정할 수 있다.
    * 비 반복 파이머 : 한번 실행된 다음 자동으로 무효화
    * 반복 타이머 : 동일한 런 루프에서 특정 TimeInterval 간격으로 실행
      * 반복 정리하려면 invalidate() 호출