---
layout: post
title: "08: 무디 차트 (Moddy Chart & Colebrook Equation)"
category: "CS/Dynamics"
comments: true
tags: [Dynamics, "Fluid Mechanics"]
feature-img: "assets/img/15.jpg"
feature-title: ""
use_math: true
series: "Fluid Mechanics"
summary: "무디 차트는 무엇인가?"
---

무디 차트는 압력강하식에서 사용되는 f의 정체이다. 파이프에서 이 식은

![image](https://user-images.githubusercontent.com/37871541/94922850-ddd2a400-04f5-11eb-8d39-7a7ace8f61e7.png){: .center}

로 정의되었었지만 사실 그렇게 만만하지 않다. 왜냐하면 레이놀즈 수에서 배웠지만 이 레이놀즈 수는 정해진 수가 아니기 때문이다. 유체가 운동하는 방향에 따라 변한다. 저 수는 유체가 측류라 가정했을 때 도출되는 식이다. 그렇다면 어떻게 해야되는가? 파이프를 예로 들었을 때, 벽면으로부터 중심부로 갈수록 유체의 레이놀즈 수는 커진다.

![image](https://user-images.githubusercontent.com/37871541/94922868-e6c37580-04f5-11eb-88b8-d903a2ee7549.png){: .center}

에서 속도가 빨라지기 때문이다. 속도가 빨라지면 어떤 문제가 생기냐 난류유동이 생긴다.(후...) 그렇기 때문에 이건 간단한 문제가 아니다. 따라서 우리는 유동이 흐를때 어디까지를 층류로 보고 난류로 볼건지 또, 어떤 특징 때문에 그렇게 되는지를 분명하게 알 필요가 있다. 즉, 측류와 난류를 간단하게 구분해보면,

1. 유체의 특징상 Re의 태생은 정해져 있기 때문에 이놈이 더 난류처럼 움직일지, 층류처럼 움직일지는 알 수 있다.
2. 하지만 추가적으로 운동하게 되면 난류효과는 어떤 유체든 커질 수 밖에 없다.
3. 이 복잡한 것을 하나로 만들어 놓은 것이 무디 차트이다.
4. 벽면에서는 파이프의 매끄러움, 즉 거칠기의 영향을 받는다.
5. 유체가 파이프를 운동할 때 벽면에서는 층류처럼 행동하는 경향이 있는데, 레이놀즈 수가 작은 층류는 이 층의 두께가 두껍고 레이놀즈 수가 큰 난류는 이 층의 두께가 얇다.
6. 층류가 벽면에 작용할 때는 이 거칠기가 유동에 영향을 끼치지 않는다. 하지만 층류의 두께가 얇게 되면 이 거칠기를 무시하지 못한다.
7. 즉 두께가 상대적으로 얇은 난류에서는 이 거칠기에 따라 유동이 변화한다.
8. 따라서 그 때 f는 Re, 거칠기의 함수이다.
9. f값에 따라 압력강하가 달라진다.

![image](https://user-images.githubusercontent.com/37871541/94922773-c1cf0280-04f5-11eb-9b6b-b25d6f80ea57.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94922787-c4c9f300-04f5-11eb-99b2-a665a74705ca.png){: .center}

Colebrook Equation는 f를 수식적으로 구할 수 있는 식이다. 자, 그러면 여러개의 property가 주어졌을 때, 압력강하를 어떻게 구할 수 있는지 3가지 유형을 정리했다. 2번째, 3번째 방법은, 반복계산법을 통해서 해를 유추하는 방법으로 구한다.

![image](https://user-images.githubusercontent.com/37871541/94922808-cabfd400-04f5-11eb-833e-a46b817c7dd0.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94922813-cd222e00-04f5-11eb-866e-8e45968d50a6.png){: .center}
