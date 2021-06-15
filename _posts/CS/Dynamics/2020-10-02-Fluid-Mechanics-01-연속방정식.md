---
layout: post
title: "01: 연속 방정식 & 나비에-스톡스 방정식 (Continuity Equation & Navier-Stokes Equation)"
category: "CS/Dynamics"
comments: true
tags: [Dynamics, "Fluid Mechanics"]
feature-img: "assets/img/15.jpg"
feature-title: ""
use_math: true
series: "Fluid Mechanics"
summary: "연속 방정식과 나비에 스톡스 방정식은 무엇인가?"
---

# Continuity Equation

연속 방정식은 질량보존법칙을 오일러 표현으로 나타내 었을 때 어떤 모양이 되는지를 설명해주는 식이다. 라그랑지언 표현을 오일러 표현으로 바꾸어주는 RTT를 사용해 미소 면적을 표현해보자. 미소면적의 중앙에서 모든 Property의 값을 갖는다고 가정했을 때, 상하좌우에서 Property의 값은 테일러 급수를 통해 값을 근사해서 나타낼 수 있다. (1계 미분까지만 표현한 것은 2계미분 항부터는 너무 크기가 작아 무시할 수 있기 때문에)

![image](https://user-images.githubusercontent.com/37871541/94920397-318ebe80-04f1-11eb-95ca-572607f99948.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94920404-3489af00-04f1-11eb-8653-c439718b1084.png){: .center}

이렇게 나온 식을 연속 방정식이라 부른다. 그런데 여기서 이 항을 조금더 풀게 되면 물질도함수의 모양으로 정리가 가능하다.다시 연속방정식을 이 모양으로 해석하게 되면, 특정 점에서 밀도의 시간에 따른 변화는 경계면에서의 속도의 발산(다이버전스)값에 밀도를 곱해준 것과 같다.로 해석할 수 있다. 여기서 만약 시간에 따라 밀도가 일정하다면, 즉, 특정점에서 밀도 변화가 없다면, (밀도 = 상수, 비압축성 유체)속도의 발산 값이 0, 즉 경계면에서 나가고 들어오는 양의 총합이 0, 우리가 생각하는 결과와 일치한다.

![image](https://user-images.githubusercontent.com/37871541/94920422-3f444400-04f1-11eb-8f2e-abe54ccab828.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94920430-41a69e00-04f1-11eb-83b5-04b2d51dd92c.png){: .center}

# Navier-Stokes Equation

나비에 스톡스 방정식은 그럼 무엇인가. 뉴턴 법칙을 오일러 관점에서 서술한 식이다. net_F = m\*a에서 RHS의 서술이 오일러 관점에서 어떻게 서술될 수 있는지 알 수 있다. 이를 바꿔주는 RTT에서 B = V를 대입해서 정리해보자. 마찬가지로 미소면적에 대해 정리하면,

![image](https://user-images.githubusercontent.com/37871541/94920460-52efaa80-04f1-11eb-9d95-7c2d6e322e85.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94920464-55ea9b00-04f1-11eb-90c1-29dd8ad3be7c.png){: .center}
여기서 비압축성 유체(밀도 = 상수)일 경우, 첫번째 항에서 밀도가 상수로 빠져나올 수 있게 된다. 그리고 비압축성 유체의 연속방정식으로 부터, 결론적으로 미소 부피의 Total F는 밀도 \* 속도에 대한 물질도함수로 나타낼 수 있다.

![image](https://user-images.githubusercontent.com/37871541/94920488-600c9980-04f1-11eb-804a-6da9d902a878.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94920498-64d14d80-04f1-11eb-93d0-cb5704b7d42f.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94920505-6864d480-04f1-11eb-866e-d3aa9f478010.png){: .center}

그런데, 이 건 외력의 총합이 시스템에서 어떻게 작용하는 지에 대한, m\*a에 대한 정리이고, 실제로 특정 시스템을 잡았을 때, 그 곳에 작용 할 수 있는 외력의 종류가 무엇이 있는지 정리할 필요가 있다. 우리가 가하는 힘을 제외했을 때, 자연적으로 발생하는 힘은 Body force와 Surface force로 나눌 수 있다. 그중 Body force는 쉽게 구할 수 있다.

![image](https://user-images.githubusercontent.com/37871541/94920539-7a467780-04f1-11eb-84f1-50a0d41fc29f.png){: .center}

표면힘이 조금 까다로운데, 미소면적의 중앙에서 작용하는 응력을 기준으로 잡았을 때, 테일러 급수에 의해 각 면에 해당하는 응력을 구할 수 있다. 이 때, 응력에 의해 이 미소면적에 작용하는 알짜 힘은 각면에서의 응력차에 해당하는 힘이 그 역할을 하므로, 다음과 같이 구할 수 있을 것이다.

![image](https://user-images.githubusercontent.com/37871541/94920556-816d8580-04f1-11eb-99cf-dc1dcee8df4a.png){: .center}

만약 3차원이라면 각포인트에서 3개의 응력항이 나오고, 이것을 행렬형태로 만든것을 응력 텐서라 한다. 이것에 대해서는 다른 포스팅에서 좀더 자세하게 다루도록 하겠다.

![image](https://user-images.githubusercontent.com/37871541/94920570-892d2a00-04f1-11eb-8eba-831e0061e5d2.png){: .center}

이것들을 한번에 나타내면, 외력은 라그랑지언 관점과, 오일러 관점에서 서술할 수 있다. 라그랑지언 관점은 기존의 생각하는 방식과 동일하게 작용하는 외력항을 다 더해준 형태를 말한다. 오일러 관점에서는 조금 변화되서 생각하는 것이 좋은데, 다른 구조물에 의한 외력을 제외했을 때, body force와 surface force로 생각한다. 이는 유체내에서 해석하기 좋게 하기 위해 식을 풀어 쓰는 것이다. ma항도 역시 라그랑지언 관점과, 오일러 관점에서 서술할 수 있다. 라그랑지언 관점은 ma로 해석하면 된다. 오일러 관점 은 물질도함수를 사용하여 나타내는데, 전역가속항과 국소가속항으로 나누어서 표현한다. 유체역학에서 ma항은 보통 오일러 관점으로 서술한다.

![image](https://user-images.githubusercontent.com/37871541/94920585-8f230b00-04f1-11eb-8fcd-5f0b60eceb22.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94920590-921dfb80-04f1-11eb-8504-dab378056aee.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94920594-95b18280-04f1-11eb-984d-ac8eff021ce1.png){: .center}

뉴튼 유체, 즉 incompressible(밀도 상수)인 유체에서 나비에 스톡스 방정식을 정리해보자. 밑 부분은 사실 벡터 형태로 정리할 경우 더 직관적인 사실을 알 수 있다. 지금은 그냥 넘어가고 다음 포스팅에서 이를 알아보자.

![image](https://user-images.githubusercontent.com/37871541/94920620-9cd89080-04f1-11eb-9ebc-b9d4e8ea2063.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94920625-a06c1780-04f1-11eb-876c-1bca5c80ad32.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/94920641-a530cb80-04f1-11eb-8414-f526290e8b6c.png){: .center}

마지막으로 이 나비에 스톡스 방정식에서 베르누이 방정식을 도출할 수 있는지 알아보자. 베르누이 정리를 쓰기위한 4가지 가정을 이 식에 적용시켜야 한다.

1. Steady
2. No friction
3. Incompressible
4. Along the Streamline

![image](https://user-images.githubusercontent.com/37871541/94920674-b4177e00-04f1-11eb-94e1-57b3be13250b.png){: .center}
