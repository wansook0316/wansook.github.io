---
layout: post
title: "02: Select Right Language and IDE"
category: "DV/Concept"
comments: true
tags: [Concept, "Development Method"]
feature-img: "assets/img/78.jpg"
feature-title: ""
use_math: true
series: "Development Method"
summary: "언어가 먼저가 아니다. 문제를 정하고 언어를 정하는 방법을 알자."
---


# 언어 선택

> 배워두면 좋은 언어가 뭐지? X 이럴거면 하지마라

1. **문제를 정의**해라. 그리고 그거에 최적화된 도구를 찾는다.
2. 언어를 골랐다면, 프레임워크가 있는지 확인해본다. - 소프트웨어가 좋아 언어를 선택하는 경우도 있다.
3. 시간, 팀원, 돈, 성능등을 모두 고려하여 선택한다.


## C/C++


* 물리 메모리 관리, IO 기능
  * 다른 언어는 불가. 운영체제가 가상 메모리 주소를 리턴
* 비트 단위 연산
  * 하드웨어를 다룬다.
* Pointer


### C

* 데니스 리치
* 절차 지향
* 컴퓨터 메모리 직접 접근 가능
* 이전의 기계어 접근 안해도된다.


### C++

* Bjarne Stroustrup
* 클래스 - 너무 방대했음
  * 재사용 유리
* 언어가 너무 어려웠음
* 하지만 여전히 많이 사용됨.
* 모바일, 웹 테크에 따라가지 못함
* 실행 파일 판매 방식 - 예전에 유행
  * 요즘은 웹 - 인터프리터 방식으로 전환
* C#으로 부족한 것 보완 - MS
* 다시 춘추 전국 시대로 넘어간 시대
* C++도 이제는 진화하고 있다.
  * C++ 14부터 모던 c++으로 불린다.



## Domain에 따라 언어를 선택하자.

* 웹서버
* 데이터 분석
* 클라우드 컴퓨팅
* 데이터 센터 프로그래밍


### 웹서버

* Javascript
  * 1995.12.04
  * 그냥 동적인 브라우저 만들려고 했다.
  * 그 안에 엔진을 뗀 것이 Node.js - 서버 사이드 개발 가능
* Apache
* Nginx
* wordpress


### 데이터 분석



* Python
  * 쉽게 공유, 배우게
  * Natural language processing에 유리
  * 쉬우니까 과학자들이 코드 공유
  * 시간이 지나면서 지식이 쌓임
* R
  * 거의 수학 공식을 그대로 가져온 형태
  * 수학하려고 만든 언어


### 클라우드 컴퓨팅

* 10년 동안의 오래된 기술
* OpenStack
  * 2010
  * **Python으로 개발**
  * NASA가 개발
  * 데이터 분석하는데 사용하면서 급성장
  * 서버 프로그래밍, 병렬 처리하는데서 요구가 많음

### 데이터 센터 프로그래밍

* 수많은 CPU, 네트워크 장비등이 들어가 있는 건물
* 전기, 전자 모든게 다 있는 곳
* 이런 곳을 위한 프로그래밍이 필요함
* 이런 것을 위해 태어난 언어 "GO" - 미래의 서버 언어
* Simple, 병렬 처리, c++ 닮은 언어, 하드웨어 다룰 수 있음, 서버 특화
* Docker라는 프로그램이 나오면서 급성장


![image](https://user-images.githubusercontent.com/37871541/116570767-78d51480-a945-11eb-8115-5e400bae934b.png){: .center-small}



# 개발 플랫폼

* OS dependant
  * 정해져 있음
* OS independant
  * VS Code
    * 플러그인
    * 확장성
    * OS independant! OS, window, linux
    * debug도 잘돼
  * Atom
    * github가 만듦
    * 웹 프로그래머
  * Eclipse
    * 자바
    * 무거움
    * 설치 많음

# 근데도 뭘할지 모르겠다면..

* Tiobe index
  * 언어 순위 발표
  * 검색 순위로 판단하는 것임
* github statistics
  * project 언어 사용기준
  * 337개 사용중
  * javascript 제일 많아
* 돈 많이 버는 걸로..


# 책추천

* Masterminds of Programming