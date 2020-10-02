---
layout: post
title: "12: 차원해석 개론 (Introduction of Dimensional Analysis)"
category: "CS/Dynamics"
comments: true
tags: [Dynamics, "Fluid Mechanics"]
feature-img: "assets/img/15.jpg"
feature-title: ""
use_math: true
series: "Fluid Mechanics"
summary: "차원 해석이란 무엇인가?"
---

차원해석은 무차원수에 대한 내용이다.

# 왜 무차원화를 하는가?

1. 실험을 할 때에 여러가지 변수에 연관된 식을 소수의 변수를 이용한 식으로 변환하여 진행할 수 있기 때문
2. 또 차원해석을 함으로써 나오는 무차원수는 시스템에 대한 직관적인 통찰을 갖게 해준다.
3. 그리고 결정적으로 이 무차원화를 한 식은 스케일링이 된 식이기 때문에 우리가 프로토타입으로 실험을 하지 않고 이를 축소한 사이즈나, 다른 공간을 사용한 곳에서 실험을 진행하여 원래 값을 도출할 수 있다.

![image](https://user-images.githubusercontent.com/37871541/94924058-d14f4b00-04f7-11eb-8f2a-893a0190bf83.png){: .center}

그런데 이 축소(상사 similarity)를 하기 위해서는 몇가지 조건이 필요하다.

상식적인 내용이지만 이 3가지의 원칙이 적용되지 않을 때 근사를 하든, 다른 방법을 모색해야 되기 때문에 완전상사인지 꼭 확인해야한다.

1. 기하학적 상사
   - 길이비가 모두 일정한 비율을 가져야 한다.
2. 운동학적 상사
   - 프로토타입에서 특정 포인트의 속도는 모형에서 속도와 비례관계가 있어야 한다.
3. 역학적 상사
   - 대응되는 힘에서도 비례관계가 있어야 한다.

이 세가지 조건을 만족했을 때, 완전상사 (Complete Similarity) 라 한다.

![image](https://user-images.githubusercontent.com/37871541/94924075-d8765900-04f7-11eb-932c-c64661ff2693.png){: .center}
