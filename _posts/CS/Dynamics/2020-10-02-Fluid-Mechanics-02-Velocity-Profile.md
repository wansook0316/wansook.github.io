---
layout: post
title: "02: 완전발달유동에서 속도 윤곽 (Velocity Profile in Fully Developed Flow)"
category: "CS/Dynamics"
comments: true
tags: [Dynamics, "Fluid Mechanics"]
feature-img: "assets/img/15.jpg"
feature-title: ""
use_math: true
series: "Fluid Mechanics"
summary: "동일하게 물이 나가는 관에서 유동의 특징은 무엇일까?"
---

완전 발달 유동이란 위치 변화에 따라 유동의 모양이 변화하지 않는 유동을 의미한다. 즉 x에 대한 편미분 값이 0이라는 의미이다. 이 경우 속도의 모양이 어떻게 이루어져 있는지 유도해보도록 하자.

# 가정

1. 2D
2. incompressible
3. μ is constant
4. steady
5. No gravity

압력과 전단력에 의한 힘 이외에 외력이 없으므로 나비에 스톡스 방정식에서 시작한다. 가정에 따라 없어지는 항들을 체크한다.

![image](https://user-images.githubusercontent.com/37871541/94921121-97c81100-04f2-11eb-85f3-4b5c13d610d7.png){: .center}

우리는 완전발달 유동 상황에서 속도 함수를 구하기 위함이므로, 완전 발단 유동의 특징을 식에 추가해준다.

$$
A1 = A2
$$

![image](https://user-images.githubusercontent.com/37871541/94921134-a0b8e280-04f2-11eb-9e21-c3a0d074d3aa.png){: .center}

신기하게도 이 가정을 연속 방정식에 넣게되면

![image](https://user-images.githubusercontent.com/37871541/94921141-a6aec380-04f2-11eb-839c-71666f586186.png){: .center}

이 만들어 진다.

![image](https://user-images.githubusercontent.com/37871541/94921155-ac0c0e00-04f2-11eb-9e03-7ea8c5a8d629.png){: .center}

다 정리하면 x축에 대해서 미분방정식이 하나,y축으로도 미분방정식이 하나가 나온다. 이 때 y축에 대한 미분방정식으로 부터 완전발달유동일 때, y축으로의 압력변화는 없다는 것을 알 수 있다. 이제 경우를 나눠서 속도 윤곽을 알아보자.

1. Couette Flow (with no pressure difference)
2. Couette Flow (with pressure difference)
3. Square area Pipe

![image](https://user-images.githubusercontent.com/37871541/94921173-b3cbb280-04f2-11eb-8b23-5e587a018da5.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94921175-b7f7d000-04f2-11eb-9892-53ab1e28ae0a.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94921183-baf2c080-04f2-11eb-9cce-db923b359e04.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94921189-bdedb100-04f2-11eb-8cae-a99b39e1d247.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94921196-c0e8a180-04f2-11eb-8593-90539fcc1fe1.png){: .center}
