---
layout: post
title: Latex equation 예쁘게 맞추기
category: "DV/Tips"
comments: true
tags: [LaTex]
feature-img: "assets/img/31.jpg"
feature-title:
use_math: true
summary: "LaTex 에서 align을 사용하여 방정식을 예쁘게 맞춰보자."
---

수식 전개를 하다보면, 계속해서 등호를 사용하여 수식의 변경요소를 보여줄 필요가 있다.

$$
A = B \\
=C\\
=D \\= \cdots = Z
$$

~~으으 못생겼다~~{: .center-text}

이런 경우 Latex 수식을 시작할 떄 align 속성을 걸어주면 예쁘게 사용할 수 있다.

$$
\begin{align}
A & = B \\
& = C \\
&= \cdots \\
&= Z.
\end{align}
$$

```
\begin{align}
A & = B \\
& = C \\
&= \cdots \\
&= Z.
\end{align}
```
