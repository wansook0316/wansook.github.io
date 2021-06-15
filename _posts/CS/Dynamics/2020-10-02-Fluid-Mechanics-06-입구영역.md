---
layout: post
title: "06: 입구영역, 입구유동 (Entrance Region or Entrance Flow)"
category: "CS/Dynamics"
comments: true
tags: [Dynamics, "Fluid Mechanics"]
feature-img: "assets/img/15.jpg"
feature-title: ""
use_math: true
series: "Fluid Mechanics"
summary: "유체가 들어가는 입구 영역에서는 유동이 달라진다."
---

지금까지는 유동 양상에 대해 공부한 것은 외력의 합이 0이 되는 상황에서만 공부했다. 그렇다면 실제로 처음 유동이 이동할 때는 어떤 모습으로 생기는지 알아보자. 이 유동이 생기는 부분을 입구영역이라고 한다.

입구영역에서는 직관적으로 알 수 있듯이 같은 속도를 유지하며 유동을 주기 위해서 Fully developed 상황보다 더 많은 압력차를 가해야한다. 그래서 이 추가적인 압력 손실 때문에 이 부분은 부손실과 많은 관련이 있다.

입구영역의 가장 핵심은 유체가 갑작스럽게 관에 들어오게 되면서 벽면효과 때문에 벽에서 속도가 0이 된다는 점이다. 처음 들어올 때, 속도 변화가 가장 크게 발생하기 때문에 이 부분에서 점성력 타우가 가장 클 것이다.

![image](https://user-images.githubusercontent.com/37871541/94922424-250c6500-04f5-11eb-83d3-d050bbafd09e.png){: .center}
자. 그렇다면 입구영역에서 압력강하가 얼마나 일어날 지 수식적으로 간단하게 증명해보자.

먼저, 입구영역에서의 전단응력이 크기 때문에 더 많은 압력차가 필요할 것이다.

그런데 이 압력강하 외에도 추가적인 압력차가 필요하다.

![image](https://user-images.githubusercontent.com/37871541/94922438-2dfd3680-04f5-11eb-9bd8-509b56bec23d.png){: .center}

유체 흐름에서 중앙에서는 점성효과를 받지 않으므로 베르누이 정리를 사용할 수 있다. 밑의 상황에서는 높이차가 없는 상황이지만 1점과 2점의 속도차가 발생하고 있는 상황이기에 필연적으로 1지점과 2지점의 압력은 달라야 한다. 이 속도차까지도 만들어야 되기 때문에 위에 서술한 커진 타우의 영향보다 더 큰 압력차가 필요하다.

![image](https://user-images.githubusercontent.com/37871541/94922449-348bae00-04f5-11eb-84f2-f84e1ec2ce51.png){: .center}
