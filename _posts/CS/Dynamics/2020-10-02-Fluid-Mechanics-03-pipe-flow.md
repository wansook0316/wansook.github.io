---
layout: post
title: "03: 파이프 유동 & 내부유동 (Pipe Flow & Internal Flow)"
category: "CS/Dynamics"
comments: true
tags: [Dynamics, "Fluid Mechanics"]
feature-img: "assets/img/15.jpg"
feature-title: ""
use_math: true
series: "Fluid Mechanics"
summary: "파이프 내에서 유체는 어떻게 움직일까?"
---

파이프란 단면적이 원형인 유로를 의미한다. 왜 굳이 원형을 가지고 파이프라고 명명했을까?

1. 고루 퍼진 원의 특성상 응력집중이 생기지 않는다.
2. 단면적 대비 둘레가 가장 작은 도형이라 점성력 효과를 최소로 줄일 수 있다,
3. 또한 단가도 최대로 줄일 수 있다.

덕트란 단면적이 사각형인 유로를 말한다. 보통 점성효과의 영향이 작을 때, 설치의 간편함 때문에 사용하는 경우가 많다.

![image](https://user-images.githubusercontent.com/37871541/94921617-9f3bea00-04f3-11eb-9176-11b081f9beb3.png){: .center}

이전 글에서는 Couette flow와 duct에서의 유동 양상을 공부했다. 이번에는 파이프에서 유동의 양상을 알아볼 것이다. 그전에 단면이 원이기 때문에 Cartesian 좌표계보다 polar 좌표계를 사용하는 것이 더 효율적일 것이다. duct에서와 마찬가지로 Fully developed 상황을 가정하고 알아보자.

![image](https://user-images.githubusercontent.com/37871541/94921641-a9f67f00-04f3-11eb-9fe5-0b9b91a91f4b.png){: .center}

Cartesian 좌표계에서는 위와 같다. 이 상태에서 Polar로 바꾸는 것은 힘드므로, Fully Developed에서는 위에서와 같이 외력이 0인 특징을 이용해서 파이프에서 속도 양상을 알아보자.

![image](https://user-images.githubusercontent.com/37871541/94921661-b084f680-04f3-11eb-929a-85a38e67bcc4.png){: .center}

으로 부터, 타우에 대해 정리 할 수 있다.

![image](https://user-images.githubusercontent.com/37871541/94921668-b4b11400-04f3-11eb-8255-e7f8e0e15e15.png){: .center}

![image](https://user-images.githubusercontent.com/37871541/94921686-bda1e580-04f3-11eb-9db3-771fe03a7794.png){: .center}

다음과 같이 구해진다.

덕트와 파이프의 양상을 비교해보면, 전체유량을 구할 떄, 속도에 대한 함수 외에도 r항이 곱해져 있기 때문에 벽면 근처로 갈수록 유량이 흐르는 폭이 증가한다. 그렇기 때문에 벽면효과를 더 많이 받는다. 결과적으로 벽면에 흐르는 유량이 많이 못 흐르는 결과를 가져오기 때문에 중앙부분에서 이 유량을 커버해야 한다.

![image](https://user-images.githubusercontent.com/37871541/94921705-c5618a00-04f3-11eb-8c9a-73019a52ae92.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94921720-cabed480-04f3-11eb-90dd-346ccbf6e9b7.png){: .center}

위에서 보듯 중앙에서 흘러야 하는 유량의 크기가 1.5에서 2로 증가했다. 앞에서 배운 Couette flow와 Duct, pipe의 속도 양상에 대한 식을 정리하면 다음과 같다.

![image](https://user-images.githubusercontent.com/37871541/94921732-d0b4b580-04f3-11eb-9c25-9d05cdadccf6.png){: .center}
