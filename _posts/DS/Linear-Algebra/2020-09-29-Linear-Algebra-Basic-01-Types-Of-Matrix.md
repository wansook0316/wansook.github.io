---
layout: post
title: "01: Types of Matrix (행렬의 종류)"
category: "DS/LA"
comments: true
tags: [Math, "Linear Algebra"]
feature-img: "assets/img/4.jpg"
feature-title: ""
use_math: true
series: "Linear Algebra Basic"
summary: "다양한 행렬 종류에 대해 알아보자."
---

# Types of Matrix

$$
A\;=\;[a_{ij}]\\
\;\\
i\;=\;m\;:row\;size\\
j\;=\;n\;\;:col\;size\\
$$

## Square Matrix

$$
m\;=\;n
$$

$$
\begin{bmatrix}
0 & 1 & 0\\
0 & 2 & 0\\
0 & 0 & 3
\end{bmatrix}
$$

## Rectangular Matrix

$$
m\; \ne\;n
$$

$$
\begin{bmatrix}
0 & 1 & 2\\
-1 & 0 & 3\\
-2 & -3 & 0\\
9 & 3 & 6
\end{bmatrix}
$$

## Zero Matrix

$$
all\;[a_{ij}]\;=\;0
$$

$$
\begin{bmatrix}
0 & 0 & 0\\
0 & 0 & 0\\
0 & 0 & 0
\end{bmatrix}
$$

## Symmetric Matrix

$$
a_{ij}\;=\;a_{ji}
$$

$$
\begin{bmatrix}
0 & 1 & 2\\
1 & 0 & 3\\
2 & 3 & 0
\end{bmatrix}
$$

## Upper-Triangle Matrix

$$
a_{ij}\;=\;0\;\;\;\;i>j
$$

$$
\begin{bmatrix}
7 & 1 & 1\\
0 & 2 & 4\\
0 & 0 & 3
\end{bmatrix}
$$

## Lower-Triangle Matrix

$$
a_{ij}\;=\;0\;\;\;\;j<i
$$

$$
\begin{bmatrix}
4 & 0 & 0\\
1 & 2 & 0\\
6 & 8 & 3
\end{bmatrix}
$$

## Diagonal Matrix

$$
a_{ij}\;=\;0\;\;\;\;if\;j\ne i
$$

$$
\begin{bmatrix}
1 & 0 & 0\\
0 & 2 & 0\\
0 & 0 & 3
\end{bmatrix}
$$

## Identity Matrix

$$
a_{ij}\;=\;0\;\;\;\;if\;\;i\ne j\\
a_{ij}\;=\;1\;\;\;\;if\;\;i=j
$$

## Skew-Symmetric Matrix

$$
a_{ij}\;=\;-a_{ji}
$$

$$
\begin{bmatrix}
0 & 1 & 2\\
-1 & 0 & 3\\
-2 & -3 & 0
\end{bmatrix}
$$

# Matrix Transformation

전치 행렬은 정사각행렬에서, 행과 열의 숫자가 같은 요소들을 기준으로 하는 선으로 행렬을 대칭 시킨 것을 말한다.

## Before Transformation

$$
\begin{bmatrix}
3 & 1 & 1\\
-1 & 3 & 1\\
-1 & -1 & 3
\end{bmatrix}
$$

## After Transformation

$$
\begin{bmatrix}
3 & -1 & -1\\
1 & 3 & -1\\
1 & 1 & 3
\end{bmatrix}
$$

## 성질

$$
(A^T)^T\;=\;A\\
(A+B)^T\;=\;A^T+B^T\\
(cA)^T\;=\;cA^T\\
(AB)^T\;=\;B^TA^T\\
if\;\;A^T\;=\;A\;,\;A\;is\;Symmetric\\
A^T\;=\;-A\;,\;A\;,\;A\;is\;Skew-Symmetric\\
I^T\;=\;I\;,\;O^T\;=\;O
$$
