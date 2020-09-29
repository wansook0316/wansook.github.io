---
layout: post
title: "03: Linear Independent, Guass-Jordan Method, Pivoting (선형 독립, 가우스-조르당 방법, 피보팅)"
category: "DS/LA"
comments: true
tags: [math, "Linear-Algebra"]
feature-img: "assets/img/4.jpg"
feature-title: ""
use_math: true
series: "Linear Algebra Basic"
summary: "선형 대수에서 중요한 선형 독립에 대해 이해하고, 해를 구하자."
---

# Linear Independence

하나의 행렬은 공간을 나타낸다고 볼 수 있다.

$$
\begin{bmatrix}
1 & 0 & 0\\
0 & 1 & 0\\
0 & 0 & 1
\end{bmatrix}\;=\;\begin{bmatrix}
\overset{\rightarrow}{i} & \overset{\rightarrow}{j} & \overset{\rightarrow}{k}\\

\end{bmatrix}
$$

다음과 같은 행렬이 있다면, column 벡터를 보면, i, j, k를 나타냄을 알 수 있다.

그런데 만약에 각각의 벡터가 서로의 상수배를 한 관계를 가지고 있다면, 이 공간은 행렬 사이즈에 해당하는 공간을 매핑하지 못한다. 이 경우 우리는 행렬이 **선형 종속** 이라 말한다. 반대로 공간을 매핑할 수 있다면 **선형 독립** 이라 말한다. 이것을 수식으로 판단해보면,

$$
\begin{bmatrix}
\overset{\rightarrow}{a_1} & \overset{\rightarrow}{a_2} & \cdots & \overset{\rightarrow}{a_n}\\
\end{bmatrix} \cdot
\begin{bmatrix}
e_1\\e_2\\ \vdots \\ e_n
\end{bmatrix}
\;=\;
\overset{\rightarrow}{0}
$$

$$
\mathbf{A}\overset{\rightarrow}{e}\;=\;\overset{\rightarrow}{0}
$$

위 식을 만족하는 e 벡터가 0 벡터인 경우 a .. 벡터들은 **선형 독립** 이라 한다. 선형 독립이 되기 위해서는 위의 행렬식에서, **Determinant 가 존재해야만 한다.** 즉, **비특이행렬** 이어야 하고, 위 식의 해인 e 벡터는 0 벡터로 **유일** 해야 한다.

$$
\mathbf{A}\overset{\rightarrow}{e}\;=\;\overset{\rightarrow}{0}\\
\;\\
\mathbf{A}^{-1}\mathbf{A}\overset{\rightarrow}{e}\;=\;\mathbf{A}^{-1}\overset{\rightarrow}{0}\\
\;\\
\mathbf{I}\;\overset{\rightarrow}{e}\;=\;\overset{\rightarrow}{0}\\
\;\\
\overset{\rightarrow}{e}\;=\;\overset{\rightarrow}{0}\\
$$

# Rank

행렬은 하나의 공간을 매핑한다고 했다. 방금은 3 x 3 의 행렬에 대해 봤기 때문에, 열벡터 공간과 행벡터 공간이 동일하게 3차원 공간을 매핑하고 있었다. 하지만 행렬이 꼭 정사각행렬이라는 법은 없다. 따라서 우리는 행벡터와 열벡터에 대한 선형 독립성을 판단할 지표가 필요한데, 이 때 등장하는 개념이 **Rank** 이다.

$$
\mathbf{A}\;=\;
\begin{bmatrix}
a_{11} & a_{12} & \cdots & a_{1n}\\
a_{21} & a_{22} & \cdots &a_{2n}\\
\vdots & & & \vdots\\
a_{m1} & a_{m2} & \cdots & a_{mn}
\end{bmatrix}\;=\;
\begin{bmatrix}
\overset{\rightarrow}{a_1} & \overset{\rightarrow}{a_2} & \cdots & \overset{\rightarrow}{a_n}\\
\end{bmatrix}\;=\;
\begin{bmatrix}
\overset{\rightarrow}{a_1}\\\overset{\rightarrow}{a_2}\\ \vdots \\\overset{\rightarrow}{a_m}
\end{bmatrix}
$$

A 행렬이 다음과 같이 있을 때, 첫번째가 열벡터로 묶은 행렬, 두번째가 행벡터로 묶은 행렬이다. A 행렬의 모든 벡터들이 선형 독립이라 가정 할때, 열벡터들의 개수가 **Column Rank(Nc)** , 행벡터들의 개수가 **Row Rank(Nr)** 이다. 만약 정사각 행렬이라면, 아래와 같다.

$$
N_c\;=\;N_r\;=\;N
$$

## Rank와 행렬식과의 관계

정사각 행렬에서 Full Rank 인 경우, 동치인 말이 여러개 존재한다.

- Full Rank
- det(A) != 0
- 역행렬이 존재한다.
- non-singular Matrix
- non-trivuial solution

# Gauss Elimination

가우스 소거법은, 연립방정식의 해를 행렬을 이용해 쉽게 구하는 방법이다. 기본적으로 행벡터의 계수를 조작하여 구하는 방법으로, **Upper Triangle Matrix, Lower Triangle Matrix** 를 만들어 구하는 방법이다. 역행렬을 구하여 답을 찾는 방식은 Cost가 많이 들어, 해를 구하는데는 적합하지 않다. 자세한 방법은 생략한다.

# Gauss - Jordan Method

가우스- 조르당 방법의 가장 큰 이점은, **역행렬** 을 구하는데에 있다. 기존의 Cramer's rule을 사용하는 것은 computing cost가 많이 들기 때문에, 이 방법이 매우 유용하다. 역행렬을 구하는데 있어 Gauss Elimination에서 한 행벡터를 조작해서 하는 방법은 동일하다.

# Pivoting

## Motivation of Pivoting

가우스 소거법과, 가우스-조르당 방법에서 대각행렬을 기준으로 수행한다는 것은 명백하다. 우리는 그래서 이 대각 행렬의 요소를 **Pivot** 이라 부른다. Pivoting 이란, 행렬이 있을때, 이 Pivot을 기준으로 행을 판단해서 두 행을 바꿔 계산하는 방법을 말한다. 그렇다면 이 Pivoting은 왜 필요한 것일까? 우리는 행렬을 계산하는데 있어 Computing Method를 사용하는데,

현실의 값을 근사해서 매핑하는 컴퓨터의 한계 때문에, 우리는 **Round Off Error** 를 필연적으로 가질 수 밖에 없다. 이 에러를 줄이기 위해 우리는 Pivoting을 한다. 예제를 살펴보자.

$$
\begin{bmatrix}
0.003 & 59.14 \\
5.291 & -6.130 \\
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2 \\
\end{bmatrix}
\;=\;
\begin{bmatrix}
59.17 \\
46.78 \\
\end{bmatrix}
$$

이 식의 정확한 값은,

$$
Exact\;Solution\\
\;\\
\begin{bmatrix}
x_1 \\
x_2 \\
\end{bmatrix}
\;=\;
\begin{bmatrix}
10.00 \\
1.0 \\
\end{bmatrix}
$$

가우스 소거법을 사용해서 위 식을 계산해보자. 우리는 대각 요소를 1로 만드는 것에 관심이 있기 때문에, 1행 1열의 값을, 2행 1열의 값과 같게 만든뒤 빼줘야 한다. 그러기 위해서

$$
{a_{11} \over a_{21}}\;=\;{0.003 \over 5.291}\;=\;1763.66\cdots
$$

이 값을 1행에 곱하고 2행을 더한 행을 2행과 바꿔주자. 결과 식은,

$$
\begin{bmatrix}
0.003 & 59.14 \\
0 & -104300\\
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2 \\
\end{bmatrix}
\;=\;
\begin{bmatrix}
59.17 \\
-104400 \\
\end{bmatrix}
$$

이 때 계산된 해는,

$$
Approximated\;Solution\\
\;\\
\begin{bmatrix}
x_1 \\
x_2 \\
\end{bmatrix}
\;=\;
\begin{bmatrix}
-10.00 \\
1.001 \\
\end{bmatrix}
$$

다음과 같이 현저히 다른 해가 도출된다. 결국 우리는 대각 요소의 값과 밑의 행이 비율이 큰 것을 피하면 된다!

$$
m_{jk}\;=\;{a_{jk}\over a_{kk}}>>1
$$

j는 행의 번호를 말하고, k는 대각 요소의 행번호를 의미한다. 우리는 이 값이 1보다 클경우 Round Off 에러가 발생한다는 것을 알았으므로 이것을 막으면 된다.

## Remedy

1. Partial Pivoting
2. Scaled Pivoting

### Partial Pivoting

가장 간단한 방법은, 저 값이 1보다 훨씬 클 경우 아래 행과 위의 행을 바꾸는 것이다!

$$
|a_{pk}|\;=\;Loop(k \le i \le n)\;max \;|a_{ik}|
$$

k는 현재 있는 행을 의미한다. n은 마지막 행을 의미한다. 그 사이에 있는 i 라는 값을 가지면서 각 행의 요소들을 조사하면서 가장 큰 값을 리턴한다. 이때, 행의 index를 저장하고, 만약 해당 행의 대각 요소의 값이 가장 크다면 **p = k** 가 될 것이다. 만약 그렇지 않다면 **p != k** 일 것이다. 이 경우 **p 행과 k 행을 Pivoting** 한다. 그렇게 되면 필연적으로 m_jk 값은 1보다 작아지므로 Round Off Error 를 피할 수 있다.

### 적용

$$
\begin{bmatrix}
5.291 & -6.130 \\
0.003 & 59.14 \\
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2 \\
\end{bmatrix}
\;=\;
\begin{bmatrix}
46.78 \\
59.17 \\
\end{bmatrix}
$$

$$
m_{jk}\;=\;m_{21}\;=\;{a_{21}\over a_{11}}\;=\;{5.291 \over 0.003}\;=\;0.000567
$$

$$
\begin{bmatrix}
5.291 & -6.130 \\
0 & 59.14 \\
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2 \\
\end{bmatrix}
\;=\;
\begin{bmatrix}
46.78 \\
59.14 \\
\end{bmatrix}
$$

$$
Approximated\;Solution\\
\;\\
\begin{bmatrix}
x_1 \\
x_2 \\
\end{bmatrix}
\;=\;
\begin{bmatrix}
10.00 \\
1 \\
\end{bmatrix}
$$

## Scaled Pivoting

만약 m 값이 1에서 크게 차이가 없다면 이 방법은 사실의미가 없다. 따라서 이 경우에는 각 행에 특정 같은 값을 곱한뒤, 답을 구하는 방법을 사용해야 한다. 가우스 소거법의 특성상, 밑의 값부터 올라오기 때문에, 특정 행의 계수들의 크기가 균등하다면 값의 변화가 크다. 따라서 우리는 행의 계수들의 비율이 큰 행을 아래로 피보팅 해야한다.

$$
\begin{bmatrix}
30 & 591400 \\
5.291 & -6.130 \\
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2 \\
\end{bmatrix}
\;=\;
\begin{bmatrix}
591700 \\
46.78 \\
\end{bmatrix}
$$

$$
S_1\;=\;max[|30|, |591400|] \; =\;591400\\
S_2\;=\;max[|5.291|, |-6.130|] \; =\;6.130
$$

$$
{|a_{11}| \over S_1}\;=\; {30 \over 591400}\;=\;0.5073\times10^{-4}\\
{|a_{21}| \over S_2}\;=\; {5.291 \over 6.130}\;=\;0.8631
$$

따라서 1행과 2행을 피보팅한다.

$$
\begin{bmatrix}
5.291 & -6.130 \\
30 & 591400 \\
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2 \\
\end{bmatrix}
\;=\;
\begin{bmatrix}
46.78 \\
591700 \\
\end{bmatrix}
$$
