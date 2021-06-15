---
layout: post
title: "05: 레이놀즈 수 유도  (Derive Reynolds Number)"
category: "CS/Dynamics"
comments: true
tags: [Dynamics, "Fluid Mechanics"]
feature-img: "assets/img/15.jpg"
feature-title: ""
use_math: true
series: "Fluid Mechanics"
summary: "레이놀즈 수를 유도해보자."
---

이번에는 레이놀즈 수를 유도하는 방법을 알아볼 것이다. 레이놀즈 수는 유체의 특징을 알려주는 무차원 수이다. 유체가 압력항에 영향을 크게 받는지, 점성항에 크게 받지를 직관적으로 알 수 있게 만든 수이다. 이 개념을 알기 위해서는 무차원 수를 알아야 하지만 난류의 이해를 위해서는 레이놀즈 수부터 알고 가는 것이 좋기에 먼저 설명하려고 한다.

레이놀즈 수는 점성계수처럼 딱 정해진 숫자라고 보기 힘들다. 밀도, 속도, 길이, 점성 이 4가지의 조합으로 이루어져 있기에 상황에 따라 변한다.밑의 예시로 든 담배연기같은 경우도 그렇다. 처음에는 고르게 올라가다가 어느순간부터 연기는 퍼진다.퍼지는 이유는 여러가지 요인이 있지만 유체가 난류의 형태로 변화했기 때문이다. 무차원수에 대해는 나중에 배우고 이번에는 그냥 받아들이면서 유도과정을 보자.

![image](https://user-images.githubusercontent.com/37871541/94922127-98fa3d80-04f4-11eb-9b83-09630bbd1458.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94922136-9e578800-04f4-11eb-9adf-42f232653049.png){: .center}

여기서 왼쪽항은 ma, 즉 관성에 의해 운동하는 항을 의미한다.

이 앞의 계수는 이 관성효과를 대변하는 수가 된다.

![image](https://user-images.githubusercontent.com/37871541/94922154-a6afc300-04f4-11eb-9d68-38fb03fa04e0.png){: .center}

반대로 점성항 앞에 있는 계수항은 점성효과를 대변한다.

![image](https://user-images.githubusercontent.com/37871541/94922163-a9aab380-04f4-11eb-96c3-33fe2a4e09a2.png){: .center}

이 두 항의 비율이 곧 레이놀즈 수이다.

![image](https://user-images.githubusercontent.com/37871541/94922172-add6d100-04f4-11eb-925a-a23e7a93b674.png){: .center}

무차원화 하는 이유에 관해서는 다음 포스팅에서 설명하도록 하겠다.

이 무차원 식을 기반으로 저번 포스팅에서 유도했던 Polar system에서 파이프 속도 양상을 구해보자.

![image](https://user-images.githubusercontent.com/37871541/94922183-b62f0c00-04f4-11eb-9206-001e99f4b92f.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94922191-b9c29300-04f4-11eb-9e69-5e784fcb40c4.png){: .center}

각각 다른 파이프지만 이렇게 Scaling을 한 뒤 일반화를 해놓게 되면, 특정 파이프의 특징에 따라 대입만하게 되면 값이 바로 도출 된다.

그럼 이번에는 파이프에서 압력강하를 구해보자. 파이프에서 평균속도와 압력과의 관계로 부터 레이놀즈 수를 사용하여 압력차를 식으로 유도해보자.

![image](https://user-images.githubusercontent.com/37871541/94922207-c0510a80-04f4-11eb-9000-b547d2b2c8ab.png){: .center}

이렇게 도출한 식은 내가 특정한 파이프에 압력차를 주었을 때, 이 압력차에 해당하는 동압이 얼마나 생길지 알게 해준다. 거기서 영향을 주는 변수는 f, L,D 이다. (~~마지막은 잘못 적었다.~~)

앞에서 본 파이프에서 압력강하는 fully developed 상황에서 이루어 진다. 만약 이 파이프에서 일정한 속도로 유체를 이동시켜야 한다고 하면 그만큼의 정압을 줘야한다는 의미가 된다. 반대로 말하면 그정도의 압력이 손실된다. 그래서 이 부분은 주손실과 관련이 있다.
