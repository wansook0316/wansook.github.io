---
layout: post
title: "05: Select Right OS"
category: "DV/Concept"
comments: true
tags: [Concept, "Development Method"]
feature-img: "assets/img/78.jpg"
feature-title: ""
use_math: true
series: "Development Method"
summary: "문제에 맞는 OS를 사용해보자."
---

# OS 선정 배경

* 비즈니스
  * 시장 점유율
    * Decktop - window 80%
    * Mobile - Android 80%, iOS 15%
    * Super Computer - Linux가 현재 잠식 100%
* 기술 요구사항
  * 병렬 프로그래밍
  * 실시간 처리
  * 극도로 작은 하드웨어 자원
  * 보안 컴퓨팅



# Linux

> 오픈 소스 다중/병렬/분산 서버 OS

* 공짜
* 많은 사람들
* 완성된 OS
* 안정적이다. - 앱의 crush가 덜 발생한다.
* 신뢰할 수 있다. - 오랜 시간 돌려도 문제 없다.
* 완전한 개발환경을 제공한다.
* 강력한 네트워크 기능 - 애초에 좋은 녀석
* Multi-user OS
* 커널
  * 가볍다.
  * iOT, sensor에 넣기 좋다.
* 네트워킹
  * 통신 서비스 많이 이걸로 만듦
* Hard한 Real-time OS
  * VXWORKS
    * 유료
    * 임베디드, 로봇, 항공, 보안, 국방, 의료를 위한 OS
    * 멀티 태스킹
    * Preemptive - 선점 스케쥴링
    * round-robin - 돌아가면서 같은 시간 배분
    * 빠른 인터럽트 응답
    * 진짜 잘 안죽는다.
    * Error handling framework
    * 다양한 부품들의 통신 프로토콜 지원(장비들)
    * 세마포어 준비 잘되어 있음
    * 메모리 방어
    * 밑바닥 디버깅 (Symbolic bebugging)


![image](https://user-images.githubusercontent.com/37871541/116595023-d4ab9780-a95d-11eb-8c1a-f8dac31aaa77.png){:. center}



# Linux vs Unix


![image](https://user-images.githubusercontent.com/37871541/116595305-26ecb880-a95e-11eb-95cb-d2f06aca426f.png){: .center}

![image](https://user-images.githubusercontent.com/37871541/116595776-a11d3d00-a95e-11eb-8c15-70e1be6e9782.png){: .center}

* Unix
  * 유료
  * 금융권에서 사용
* Linux
  * 무료
  * 더 빠르다.


# Zephyr

* 최근에 만들어진 OS
* Microcontroller OS
* 라즈베리는 OS가 있지만 아두이노는 없다.
* 애초에 쓸수있는 하드웨어가 굉장히 작기 때문
* 이런 곳에 사용할 수 있는 OS를 만들었다..!
* Linux Foundation에서 지원한다.
* Highly configurable(수정가능), Highly Modular
  * 모든 기능이 다 필요한 것이 아니니 모듈화가 잘되어 있어야 갖다가 쓸 수 있다.
* Kernel mode only
  * 커널이라 애플리케이션을 나누는게 아니고 합쳐버려
  * Nanokernel: 진짜 완전히 다때려박고 합쳐 (10k미만)
  * Microkernel: 야야 그래도 조금은 나누어서 하자.
  * user-space가 없다. - app module 이런거 없다.
  * no-dynamic runtimes
    * c++에 dll(dynamic linked library) - 필요할 때만 메모리에 불러쓰고 지워버리는 기법 이런거 못쓴다.
    * 동적할당 그런거 안한다.
    * Cross architecture(arm, arc, ia32)
    * 멀티 코어(cpu 여러개), 멀티 프로세스(여러개의 프로세스가 돌아가는 경우), 멀티 스레드(일꾼을 여러명) 중에 멀티 스레드 지원
    * 커널만 따지면 딱 2kb..!
    * 센서
    * 태그
    * 입는 LED 
    


![image](https://user-images.githubusercontent.com/37871541/116598265-93b58200-a961-11eb-92c3-0030ebcecfe9.png){: .center-small}_단지 작을 뿐 아래 보면 있을 것 다있다._


# 보안 OS

* Trustzone - arm
  * 데스크톱에서는 별 필요 없었는데 휴대폰은 너무 중요
  * 그래서 어느정도 성공
  * 하드웨어, 소프트웨어 융합된 기술
  * 컴퓨터 안에 2개의 운영체제가 돌아가고, 들어가기 위해서는 보완기능을 해제해야 하는 구조
  * 오염이 되었다고 판단하면 접근 제한
