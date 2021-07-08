---
layout: post
title: "19: 동시성, 비동기, 병렬 프로그래밍"
category: "DV/Swift"
comments: true
tags: [iOS, "Concurrency", "Asynchronous", "Pararllism"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "PhotoKit에 대해서 알아보자."
---

# 프로세서

* 하드웨어 유닛
* CPU
* 여러개의 프로세서를 가질 경우 멀티 프로세서


# 코어

* 프로세서 내에서 주요 연산회로
* 여러개의 코어를 가진 프로세서도 멀티 프로세서라 함


# 프로그램(Program)과 프로세스(Process)

* 프로그램
  * 보조 기억장치에 저장된 실행 코드
  * 생명이 없음
* 프로세스
  * 메모리상에서 실행되는 작업 단위
  * 동시에 여러개의 프로세스를 시분할 방식으로 운용하는 것을 멀티태스킹이라고 함


# 스레드(Thread)

* 하나의 프로세스 내에서 실행되는 작업 흐름의 단위
* 하나의 프로세스에는 하나이상의 스레드를 동시에 실행할 수 있음
* 프로그램이 실행된 이후 계속 동작하는 스레드를 메인 스레드
* 이외 스레드를 서브 스레드라 함


# 비동기 프로그래밍

* 주 실행흐름을 멈춰서 기다리지 않고, 바로 다음 작업을 실행할 수 있게 하는 방식
* 실행 결과 처리를 별도의 공간에 맡기고, 결과를 기다리지 않은 상태로 다음 코드를 실행하는 병렬 처리 방식
* 이를 구현하는 방법은 언어, 프레임워크마다 다름


# 동시성 프로그래밍

* 논리적으로 동시에 하는 것 처럼 보이도록 하는 방식
* 싱글코어 또는 멀티 코어에서 멀티 스레드를 동작시키기 위해 여러개의 스레드가 <mark style='background-color: #fff5b1'> 번갈아 가면서 </mark> 실행되는 방식
* 병렬적인 것처럼 보이지만 번갈아면서 실행되는 것


# 병렬 프로그래밍

* 물리적으로 정확히 동시에 실행되는 것을 말함
* 멀티 코어에서 멀티 스레드를 동작시키는 방식

## 데이터 병렬성

![image](https://user-images.githubusercontent.com/37871541/124936963-eedeb180-e041-11eb-8af6-200c08030501.png){: .center-verysmall}_데이터 병렬성_

* 전체 데이터를 나누어 서브 데이터로 만들고, 이 서브데이터를 병렬 처리해서 빠르게 작업을 수행

## 작업 병렬성
![image](https://user-images.githubusercontent.com/37871541/124936985-f3a36580-e041-11eb-80cc-7610ec595933.png){: .center-verysmall}_작업 병렬성_

* 서로 다른 작업을 병렬 처리함



# 동시성과 병렬성의 차이


![image](https://user-images.githubusercontent.com/37871541/124937262-2f3e2f80-e042-11eb-9e12-8cb14d5b7794.png){: .center}_동시성과 병렬성_

애초에 처리하는 사람이 몇명이냐가 핵심. 동시성은 두개의 큐를 번갈아가면서 작업해서 뒤에 있는 사람이 보기에는 두명이 작업하는 거라고 착각할 수도 있다.

||동시성|병렬성|
|:-:|:-:|:-:|
|개념|논리적|물리적|
|동작 가능 환경| 싱글 코어, 멀티 코어| 멀티 코어|


# iOS에서의 동시성 프로그래밍 지원 종류


* Grand Central Dispatch(GCD)
  * 멀티 코어와 멀티 프로세싱 환경에서 최적화된 프로그래밍을 할 수 있도록 애플이 개발한 기술
* 연산 대기열(Operation Queue)
  * 비동기적으로 실행되어야 하는 작업을 객체 지향적인 방법으로 사용
* Thread
  * 멀티 스레드 프로그래밍을 위한 애플에서 제공하는 스레드 클래스


# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/16866?isDesc=false)
* [GCD](https://en.wikipedia.org/wiki/Grand_Central_Dispatch)
* [Thread](https://developer.apple.com/documentation/foundation/thread)
* [OperationQueue](https://developer.apple.com/documentation/foundation/operationqueue)
