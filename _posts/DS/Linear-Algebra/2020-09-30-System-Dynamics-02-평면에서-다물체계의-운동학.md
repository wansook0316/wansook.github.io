---
layout: post
title: "02: 평면에서 다물체계의 운동학"
category: "DS/LA"
comments: true
tags: [math, Dynamics, "Linear-Algebra"]
feature-img: "assets/img/4.jpg"
feature-title: ""
use_math: true
series: "System Dynamics"
summary: "평면에서 어떻게 움직이는지 알아보자."
---

# Kinematics of Planer Multibody Systems

평면에 놓인 특정 물체를 나타내려면 어떻게 해야할까? 그 물체를 나타내기 위해 우리는 기준을 잡아서 설명해야 할 것이다. 즉 **절대좌표** 가 필요하다.

먼저 물체의 질량 중심을 가리키는 좌표가 존재할 것이고, (x, y) 그리고 그 물체의 형상을 나타낼 때에 기준으로 잡은 **상대좌표** 가 필요하다. 이유는 물체는 위치정보 이외에도 회전에 대한 정보도 있기 때문에 이것을 표현하기 위해서는 물체기준으로 만들어진 기준이 필요하다. 즉, 절대좌표와 상대좌표가 얼마나 회전했는지에 대한 지표가 필요하다.

<img width="500" alt="스크린샷 2019-04-26 오후 4 07 25" src="https://user-images.githubusercontent.com/37871541/56789633-50d5e680-683d-11e9-9196-bbdb0f1e5d8c.jpg">{: .center width="50%"}

- 2D
  - Rx, Ry, T : 3개
- 3D
  - Rx, Ry, Rz, Tx, Ty, Tz : 6개

# Degree Of Freedom

**계의 운동을 정확히 표현하기 위해 필요한 최소한의 좌표 수** 를 자유도라 한다.

$$
dof\;k\;=\;n\;coordinates \;-\;m\;independent\;equations\;of\;constraint
$$

## 좌표계의 총 개수

여기서 n coordinates는 해당 시스템의 좌표의 총 개수를 의미한다. coordinates의 개수 n은, 해당 시스템의 물체수와 관련이 있다.

<img width="500" alt="스크린샷 2019-04-26 오후 4 07 25" src="https://user-images.githubusercontent.com/37871541/56787664-34837b00-6838-11e9-930d-7e998d9a87a2.jpg">{: .center width="50%"}

이와 같은 시스템이 있을 때, 이 시스템을 나타내기 위해서는, 절대좌표, 또 각각의 물체에서 사용해야하는 좌표계까지 12개이다.

$$
3 + 3\times3\;=\;12
$$

우리는 보통 Ground를 절대좌표로 잡으며, 그렇기 때문에 이 시스템을 볼때, Ground, 크랭크, 커플러, 종동절 총 4개의 물체가 있다고 생각하고 각각의 물체가 2D에서 정의되어 있기 때문에 각각의 좌표계는 Rx, Ry, T 3개씩의 좌표가 필요하다. 따라서 12개가 총 필요한 좌표계의 수이다.

## 구속식의 개수

그런데 저 시스템의 자유도는 1이었다. 그렇다면, 1개의 좌표만이 저 시스템의 운동학적 형상을 결정짓는데 영향을 준다는 얘기인데, 다른말로 하면 제약 조건이 11개라는 소리다.

그 제약조건은 어떤 것 때문에 발생할까? 각각의 물체에 연결되어 있는 Joint 때문이다. 이 시스템에서 각각의 Joint는 연결되어 있는 물체가 길이방향, 길이에 수직인 방향으로 움직이는 것을 제한하고 있다.

$$
4\;\times\;2 = \;8
$$

8개의 제약이 Joint에서 발생한다. 또한, Ground는 이 시스템 전체에서 기준점 역할을 하고 있다. 위에서 3개의 좌표를 가질 수 있다고 계산은 했지만, Rx, Ry, T 각각이 상수값을 가져야 하므로, 제약 역시 세 좌표에 대해서 가지고 있다.

$$
Rx\;=\;c_1,\;\;R_y\;=\;c_2,\;\;\theta\;=\;c_3
$$

따라서 Ground 에 대한 제약은 3이다. 결론적으로 전체 제약 조건은,

$$
8\;+\;3\;=\;11
$$

11이다.

## DOF calculation

그래서 DOF는 다음과 같이 계산할 수 있다.

$$
n\;=\;3\;\times\;4\\
\;\\
m\;=\;3\;+\;2\;\times\;4\\
\;\\
dof\;k\;=\;n\;-m\;=\;12\;-\;11\;=\;1
$$

## Types of Mechanical Joints

<img width="1117" alt="스크린샷 2019-04-26 오후 5 43 26" src="https://user-images.githubusercontent.com/37871541/56795159-cf855080-684a-11e9-9110-3a16dff7ed2e.png">{: .center width="80%"}

1. Prismatic Joint (Translational joint)
   - 한 방향으로만 움직일 수 있게 만든 joint
   - 따라서 2D 인 경우 제약 조건은 2이다.
   - 3D 인 경우 제약 조건은 5이다.
2. Revolute Joint (Pin joint)
   - 한 방향으로 회전할 수 있게 만든 joint
   - 따라서 2D 인 경우 제약 조건은 2이다.
   - 3D 인 경우 제약 조건은 5이다.
3. Cylindrical Joint
   - 회전과 한 방향으로 움직일 수 있게 만든 joint
   - 이 joint 경우 2D에서는 사용할 수 없다.
   - 3D 인 경우 제약 조건은 4이다.
4. Spherical Joint (ball Joint)
   - 세 방향으로 회전만 가능하게 만든 joint
   - 따라서 2D 인 경우는 정의되지 않는다.
   - 3D 인 경우 제약 조건은 4이다.
