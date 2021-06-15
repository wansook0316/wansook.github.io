---
layout: post
title: "07: 왕복 사이클 (Reciprocating Engines)"
category: "CS/Dynamics"
comments: true
tags: [Dynamics, Thermodynamics]
feature-img: "assets/img/14.jpg"
feature-title: ""
use_math: true
series: "Thermodynamics"
summary: "실제 왕복하는 사이클에 대해 알아보자."
---

왕복엔진이라 함은, 가솔린 엔진과 디젤 엔진으로 나뉜다. 기본적으로 피스톤의 왕복운동을 기반으로 Shaft work을 생산하기 때문에 그렇다.

# 종류

1. Spark-ignition (Gasolin)
2. compression-ignition (Diesel)

# 기본적으로 알아야 하는 것

- MEP (Mean Effective Pressure)
  - 피스톤이 움직이는 최대 부피대비 일 생산량 (kPa)
  - 왕복엔진의 성능을 판단하는 척도가 된다.
  - $W_{net} = MEP * (V_{max} - V_{min})$
- Compression Ratio
  - r = Vmax/Vmin
- Actual : 4 stroke, open system
- Ideal : 2 stroke, closed system
- ISENTROPIC RELATION

![image](https://user-images.githubusercontent.com/37871541/94918721-153d5280-04ee-11eb-9be7-3b6908692c79.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94918734-1d958d80-04ee-11eb-8c3c-fa653d1456d8.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94918756-271ef580-04ee-11eb-9466-6b2be4afa3db.png){: .center}

## OTTO Cycle

> Ideal Cycle for Spark - ignition Engine
> ​

- Process : 등엔트로피 수축 -> 등적 Heat in -> 등엔트로피 팽창 -> 등적 Heat out
- Efficiency : r (압축비) 의 함수, 높을 수록 증가한다.
- Problem : 압축비가 높을 때 효율이 좋지만 자연발화의 가능성이 있다.

![image](https://user-images.githubusercontent.com/37871541/94918866-65b4b000-04ee-11eb-8e0f-69cde00b4a32.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94918815-4a49a500-04ee-11eb-8524-d06b08ad0838.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94918907-749b6280-04ee-11eb-810e-8a43c39c21d4.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94918917-79601680-04ee-11eb-8c56-4eb3b4bcc306.png){: .center}

## Diesel Cycle

> Ideal Cycle for Compression - ignition Engine
> ​

- Difference : OTTO에는 혼합기체가 압축된다. Diesel은 공기만 압축된다.
  ​ _ 자연발화의 가능성을 제거
  ​ _ 높은 압축비에서 운행 가능
- Process : 등엔트로피 수축 -> 등압 Heat in -> 등엔트로피 팽창 -> 등적 Heat out
- Efficiency : r (압축비)와 rc(부피비) 의 함수
- Problem : 질소산화물 배출, r (압축비) 가 같을 경우 OTTO보다 효율이 낮다.

![image](https://user-images.githubusercontent.com/37871541/94918941-82e97e80-04ee-11eb-9db2-a86545d56293.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94918947-85e46f00-04ee-11eb-9ff8-8e84d67edad0.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94918955-8846c900-04ee-11eb-8a3b-59c764b368be.png){: .center}
