---
layout: post
title: "05: 데이터 탐색"
category: "DS/ML"
comments: true
tags: [Data Science, "Machine Learning", "빅데이터분석기사"]
feature-img: "assets/img/77.jpg"
feature-title: ""
use_math: true
summary: "데이터 탐색 방법에 대해 알아본다."
series: "빅데이터분석기사 - 필기"
---

# 데이터 탐색 개요

* 분석전 그래프, 통계 방법을 통해 직관적으로 파악


## EDA

* Resistance(저항성)
  * 오류값이 있어도 영향을 적게 받음
  * 평균보다 중앙값
* Residual(잔차값)
  * 경향으로 부터 얼마나 벗어났는지 파악
* Re-expression(자료 재표현)
  * 데이터 변환을 통해 구조 파악
* Graphic Representation(현시성)
  * 데이터 시각화

## 개별 변수 탐색 방법
* 범주형 데이터
  * 명목 척도, 순위 척도
  * 빈도수, 최빈값, 비율, 백분율
  * 막대형 그래프
* 수치형 데이터
  * 등간 척도, 비율 척도
  * 평균, 분산, 표준 편차, 첨도, 왜도
  * 박스 플롯, 히스토그램

## 다차원 데이터 탐색 방법

* 범주-범주
  * 막대형 그래프
* 수치-수치
  * 산점도
  * 공분산
  * 피어슨 상관계수 - **방향, 강도**
* 범주-수치
  * 박스 플롯

# 상관 관계 분석

* 산점도
* 공분산
  * 강도는 나타낼 수 없음
  * 방향은 알 수 있음
* 상관계수
  * 방향성과 강도 알 수 있음
  * -1~1의 값

* 수치적 데이터 - 피어슨 상관계수
* 순서적 데이터 - 스피어만 상관 분석
* 명목적 데이터 - 카이제곱 검정


# 기초 통계량 추출 및 이해

* 중심 경향성
  * 평균 - 이상값에 치우치는 경향
  * 중위수
  * 최빈값
* 산포도
  * 범위 - (최댓값-최솟값)
  * 분산
  * 표준편차
  * 변동계수(CV) - $\sigma \over E(X)$
  * 사분위수 범위 - (Q3-Q1)
* 분포
  * 왜도 - 치우친 정도
    * 값 < 0 -> 꼬리 왼쪽
    * 값 > 0 -> 꼬리 오른쪽
  * 첨도 - 뾰족한 정도
    * 값 = 0 - 정규분포
    * 값 < 0 - 퍼짐
    * 값 > 0 - 뾰족함

# 시각적 데이터 탐색

![image](https://user-images.githubusercontent.com/37871541/114735567-45f52300-9d80-11eb-9a00-4582fa0481af.png){: .center-small}



* 히스토그램
  * 막대 붙어 있음
  * 가로축은 수치형 데이터
  * 넓이는 일정
* 막대형 그래프
  * 막대 떨어져 있음
  * 가로축 수치형 아니어도 됨
  * 넓이는 다를 수 있음
* 박스 플롯
* 산점도

# 시공간 데이터 탐색

![image](https://user-images.githubusercontent.com/37871541/114735894-953b5380-9d80-11eb-84ca-ffb260dcc07b.png){: .center-verysmall}
![image](https://user-images.githubusercontent.com/37871541/114735935-9e2c2500-9d80-11eb-8201-4ef13ee53fec.png){: .center-verysmall}
![image](https://user-images.githubusercontent.com/37871541/114735971-a6846000-9d80-11eb-9611-63793a624290.png){: .center-verysmall}



* 코로플레스 지도(등치지역도)
  * 크기에 따라 색을 다르게
  * 지역 크기는 그대로
* 카도그램(변량비례도)
  * 값에 따라 지도 면적이 왜곡됨
* 버블 플롯맵

