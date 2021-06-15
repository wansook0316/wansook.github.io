---
layout: post
title: "10: 파이프 연결망(네트워크) & 펌프선택 (Piping Network &Pump Selection)"
category: "CS/Dynamics"
comments: true
tags: [Dynamics, "Fluid Mechanics"]
feature-img: "assets/img/15.jpg"
feature-title: ""
use_math: true
series: "Fluid Mechanics"
summary: "파이프 네트워크에 따른 계산과, 그에 따른 펌프를 선택해보자."
---

우리가 관을 매개로 한 시스템을 구성했을 때, 두 가지의 손실이 발생한다고 배웠다. 주손실과 부손실이 그것인데, 우리는 여기서 회로도와 관 네트워크의 유사성을 알 수 있다. 유동을 일으키는 압력은 전압과, 그에 따르는 유량은 전류와, 이를 방해하는 손실을 저항과 대응할 수 있을 것이다.

그렇다면 총 옴의 법칙과 같이 이 값도 대응이 될 것이다. 또한 회로에서 직렬, 병렬 개념도 같게 대응이 될 것이다.

![image](https://user-images.githubusercontent.com/37871541/94923479-e4155000-04f6-11eb-9ddf-f4e93a8158cc.png){: .center}

자, 그런데 유체는 일정한 압력차가 있어야 고정된 유량으로 계속 흐를 수 있다. 하지만 현실을 유체가 흐름에 따라 해당위치에서 압력(수두)는 감소한다. 초기부터 엄청나게 큰 P를 파이프 입구에서 주면 되겠지만 현실적으로 힘들다. 따라서 중간에 압력을 추가적으로 가해 유량을 증가시키는 행위가 필요하다. 이것이 펌프! 먼저 펌프의 원리와, 각각의 펌프가 갖는 효율을 구해보자.

![image](https://user-images.githubusercontent.com/37871541/94923499-ec6d8b00-04f6-11eb-95e3-f4c458054a29.png){: .center}

결과적으로 펌프의 효율은 전기에너지가 축에너지로 바뀔때, 축에너지가 펌프로 전해지면 유체를 가속시킬 때의 효율과 연관이 있다.

그렇다면 시스템과 펌프사이에서 어떤 펌프를 고르는 것이 가장 효율적일까? 첫번째로 펌프자체가 갖는 압력과 유량의 관계가 있을 것이다. 예를 들어 h만큼의 수두를 제공할 수 있는 펌프가 있다고 하자. 그런데 펌프의 양쪽의 inlet, outlet이 막혀있다. 그렇다면 펌프가 하는 일은 모두 해당 포인트에서 압력을 높히는데 사용될 것이다. 만약 적당량의 유체가 흐르면, h만큼의 수두에서 유체를 흐르게 하는 양만큼의 수두가 감소하고 나머지는 여전히 압력을 증가시킬 것이다. 즉, 펌프의 입장에서 봤을 때, 수두와 압력간에는 일종의 -정비례 관계가 있다. 엄밀하게 알아보기 위해 간단한 유도를 해보자.

![image](https://user-images.githubusercontent.com/37871541/94923575-09a25980-04f7-11eb-9b61-f4eb358b6bc6.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94923583-0c9d4a00-04f7-11eb-9cb3-b1f8af6d3418.png){: .center}

다음과 같이 빨간 실선이 펌프의 압력손실, 즉, 유량을 생기게 한 양이다. 자, 그러면 펌프가 정해졌을 때, 수두와 유량간의 관계는 알았다. 그럼 이 펌프의 수두량은 어떻게 구해질까? (죄송합니다. 샤프트 일은 아래 식이 맞습니다.)

![image](https://user-images.githubusercontent.com/37871541/94923602-158e1b80-04f7-11eb-95c4-b240d2eff209.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94923608-18890c00-04f7-11eb-83d2-929f76337c1b.png){: .center}
내부에너지 항과 열항을 한데 묶어 역학적 손실항이라 한다. 아까 전체 식을 질량속도로 나누었으므로 여기서 W항은 w로 단위질량당 일이 된다. (이는 곧 압력이다! 밑에 유도식을 보자) w_pump를 구해보자.

![image](https://user-images.githubusercontent.com/37871541/94923621-1e7eed00-04f7-11eb-86a0-34acbf9bf8dd.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94923629-2179dd80-04f7-11eb-838f-bac182db99b2.png){: .center}

아! 펌프의 수두량은 로스항과 높이차로 구할 수 있다. 이렇게 펌프 수두를 구할 수 있다. 펌프 수두를 계산할 때 높이차를 감안하고 생각하면 쉽다는 얘기이다. 시스템에서 원하는 압력차는 기존에 배웠던 주손실 식을 사용하면 구할 수 있다. 이 두그래프의 교점이 최적의 펌프를 선택하는 방법이다.

![image](https://user-images.githubusercontent.com/37871541/94923646-276fbe80-04f7-11eb-8b7c-1b8c908ad91f.png){: .center}
