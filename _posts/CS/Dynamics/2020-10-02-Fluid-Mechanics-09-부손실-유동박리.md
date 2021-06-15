---
layout: post
title: "09: 부손실 & 유동 박리 (Minor Loss & Flow Separation)"
category: "CS/Dynamics"
comments: true
tags: [Dynamics, "Fluid Mechanics"]
feature-img: "assets/img/15.jpg"
feature-title: ""
use_math: true
series: "Fluid Mechanics"
summary: "주손실 말고 부손실은 무엇이고 유동 박리 현상은 무엇인가?"
---

주손실은 이미 공부했고, 이번에는 부손실에 대해 공부해보자. 부손실은 입구영역에서 발생하는 것도 포함하지만 더 주가 되는 유동박리에 의해서 일어난다. 유동이 관을 타고 지나갈 때, 관의 형태 때문에 부차적으로 생기는 손실을 의미한다. 낮은 속도에서 유체가 장애물을 지나갈 때는 만나는 면에서 유체의 초기속도가 작기 때문에

![image](https://user-images.githubusercontent.com/37871541/94923177-65b8ae00-04f6-11eb-8da4-27453aee1384.png){: .center}_벽면에서 속도 = 0, 그 바로위에서 속도가 작으므로 변화율도 작다_

점성응력(마찰이다 사실) 이 작다. 그래서 끝면 까지 갈 수 있다. 그런데 빠른속도 일 경우 점성응력이 매우커진다. 그렇게 되면 끝점까지 가기전에 속도가 0이 되는 지점이 생기고 유체가 떨어져 나간다. 이 때, 역방향으로 작용하는 압력차를 역압력 구배(adverse pressure gradient) 라 한다.

![image](https://user-images.githubusercontent.com/37871541/94923197-6b15f880-04f6-11eb-9771-cb71f59ad39c.png){: .center}

여기서 골프공이 움푹파인 이유를 알 수 있다. 움푹파이게 되면 표면적이 넓어져 점성효과가 커져 더 빨리 박리가 일어날 것 같지만 구멍은 거칠기 역할을 한다!! 거칠기가 커지게 되면 유체는 더 난류유동으로 운동하며 난류유동의 특징인 높은 관성효과, 즉 난류유동을 일으켜 압력 회복이 좋기 때문에 더 멀리 날아간다. 주손실과 부손실을 합친 항을 전체 손실이라 한다

![image](https://user-images.githubusercontent.com/37871541/94923220-75d08d80-04f6-11eb-972e-de0d66d83417.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94923226-79641480-04f6-11eb-9604-93a9cd67088d.png){: .center}
