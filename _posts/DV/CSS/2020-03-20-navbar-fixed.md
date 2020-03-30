---
layout: post
title: navbar, footer 고정하기
category: "DV/CSS"
comments: true
tags: [css, position, fixed]
feature-img: "assets/img/20.jpg"
feature-title:
use_math: true
---

상단 navbar나 footer 같이 고정할 필요성이 있는 html 요소를 어떻게 빠르게 만들지 정리했다.

이 부분을 생각할 때 조금 어려웠던 것은, navbar 같은 경우, 어떻게 html 구조를 짜야되는 지 였다. 하지만 조금만 생각해보니, 굳이 떼어내서 구조화할 필요 없이 그냥 필요한 요소들을 만들고, 이를 보여주는 방식, css에서 display만 변화시키면 되는 문제였다.

물론, 이 과정에서 class 이름을 바꾸고 body를 해당 nav의 높이 만큼 padding 혹은 margin을 주어야 하지만, html 구조에 있어 navbar는 그대로 두어도 상관없다.
