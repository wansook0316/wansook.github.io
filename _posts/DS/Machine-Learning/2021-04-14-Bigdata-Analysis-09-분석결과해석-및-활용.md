---
layout: post
title: "09: 분석결과 해석 및 활용"
category: "DS/ML"
comments: true
tags: [Data Science, "Machine Learning", "빅데이터분석기사"]
feature-img: "assets/img/77.jpg"
feature-title: ""
use_math: true
summary: "모델의 평가 방법, 개선 방법에 대해 알아보자."
series: "빅데이터분석기사 - 필기"
---


# 분석 모형 평가

모델을 평가하는데 사용하는 평가 지표에 대해 알아보자.
## 예측 모형

<img width="713" alt="스크린샷 2021-04-15 오후 4 48 23" src="https://user-images.githubusercontent.com/37871541/114833308-67025600-9e0a-11eb-814c-af59842d6f67.png">{: .center-small}


* SSE(Error Sum of Square) - 오차 제곱합 : 예측값과 실제값 차이
* SST(Total Sum of Squares) - 전체 제곱합 : 평균과 실제값 차이
* SSR(Regression Sum of Square) - 회귀 제곱합 : 예측값과 평균 차이
* AR(Average Error) - 평균 오차 : 부호 있음
* MAE(Mean Absolute Error) - 평균 절대 오차 : 부호 없음(절댓값)
* RMSE(Root Mean Squared Error) - MSE(SSE 평균 낸 것)에 루트
* MAPE(Mean Absolute Percentage Error) - 절대값으로 백분율
* MPE(Mean Percentage Error) - 오차 부호 있음, 백분율
* 결정계수(R Square) - $SSR \over SST$
  * 수정된 결정계수
  * 결정 계수는 변수가 증가하기만 하면 증가함
  * 적절하지 않은 변수에 대해 페널티를 부과한 지표
  * 그래서 항상 결정계수보다 값은 작을 수 밖에 없음


## 분류 모형


혼동 행렬에 대해 알아보자.

|실제(▼) 예측(▶)  | O | X |
|:-:|:-:|:-:|
| O | True Positive | False Negative |
| X | False Positive | True Negative |

* 정확도
  * T, F를 정확하게 예측한 비율
  * ${TP + FN} \over {TP + TN + FP + FN}$
* 민감도(Recall)
  * 실제 예측 중 잘맞춘 비율
  * $TP \over {TP + FN}$
* 특이도
  * 실제 부정 중 잘맞춘 비율
  * $TN \over {FP + TN}$
* 정밀도
  * 예측 긍정 중 잘맞춘 비율
  * $TP \over {TP + FP}$
* F1 Score
  * 정밀도와 민감도 조화평균
  * $2\times{Precision \times Recall} \over {Precision + Recall}$


* ROC 곡선
  * 가로 : 1-특이도
  * 세로 : 민감도(Recall)
  * 왼쪽 위로 갈수록 좋음
  * 그래서 넓이(AUC)로 판단, 1이면 좋은 모형
  * AUC는 0.5~1.0 사이 값 가짐


## 교차 검증

![image](https://user-images.githubusercontent.com/37871541/114836896-155bca80-9e0e-11eb-8dca-260eb30f0632.png){: .center-small}

* 홀드 아웃 교차 검증
  * 전체 데이터 비복원 추출로 Training/Test로 나눔
  * 5:5, 3:7, 2:1
  * 데이터 손실 발생
* 랜덤 서브샘플링
* K-Fold
  * K의 부분집합으로 나누고 1개를 Test, 나머지는 Training
* LOOCV
  * 1개의 샘플만 TEST
* LpOCV
  * p개의 샘플만 TEST
* 부트스트랩
  * **복원 추출**
  * 전체 데이터가 N개, N개 부트스트랩 -> 한번도 안뽑히는 녀석 37.8%
  * 그녀석을 test로 사용


## 모수 유의성 검증

![image](https://user-images.githubusercontent.com/37871541/114837090-489e5980-9e0e-11eb-948b-53fd0536b86d.png){: .center-small}

* 기본 통계 내용이라 생략


## 적합도 검정

* 표본 집단 분포가 주어진 이론을 따르는지 검정한다.


* 카이제곱 검정
  * `chisq.test()`
* 정규성 검정
    * 샤피로-윌크 검정
      * 정규 분포를 따르는가?
      * `sharpiro.test()`
    * 콜모고로프-스미르노프 적합성 검정
      * 특정 분포를 따르는지 검정하는 방법
  * Q-Q plot
    * 시각적으로 검정
    * 대각선 참조선을 따라서 분포하면 만족
    * 해석은 값이 아니기 때문에 주관적

# 분석 모형 개선

* 고도화 방법을 알아본다.
## 과대 적합 방지

* 데이터 증강
* 복잡도 감소
  * 은닉층 수 감소
  * 수용력 감소
* 가중치 규제
  * 하이퍼 파라미터임
  * L1
  * L2
* 드롭아웃


## 매개변수 최적화

* 경사하강법
  * SGD
  * 모멘텀 - 관성 사용
  * AdaGrad - 학습률 점점 줄이는 방법
  * Adam - 모멘텀, AdaGrad 둘다적용


## 분석 모형 융합

* 취합 방법론
  * 다수결
    * 직접 투표 - 단순 투표
    * 간접 투표 - 가중치
  * 배깅
    * 복원추출 학습 데이터 셋 분리
  * 페이스팅
    * 비복원 추출 학습 데이터 셋 분리
  * 랜덤 서브스페이스
    * 다차원 독립 변수중 일부 차원을 선택
    * 데이터는 모두 사용, 특성 샘플링
  * 랜덤 패치
    * 학습 데이터, 변수 모두 랜덤 사용
  * 랜덤 포레스트
    * 의사결정나무를 개별 모형으로 합침
    * 독립 변수를 모두 비교하여 최선의 독립변수 선택
* 부스팅 방법론
  * AdaBoost
  * Gradient Boost

