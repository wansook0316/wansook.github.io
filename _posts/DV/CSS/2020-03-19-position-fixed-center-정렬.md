---
layout: post
title: position fixed에서 중앙 정렬하기
category: "CS/CSS"
comments: true
tags: [css, center-arrangement, position, fixed]
feature-img: "assets/img/20.jpg"
feature-title:
use_math: true
---

position : fixed에서 중앙 정렬하는 방법

```css
.class {
  position: fixed;
  /* fixed를 쓸 때에는 width, height를 명시해줘야 한다. */
  width: 80%;
  /* left, right는 해당 요소의 위치 시작점을 결정한다. 그런데, 이때, margin의 양 값을 auto로 줌으로써 마진을 주어 해당 요소의 양 끝 위치를 각각 0으로 만들어준다. */
  margin: 0 auto;
  left: 0;
  right: 0;
  /* 다른 것들 */
  display: flex;
  background-color: red;
  padding: 20px 50px;
  border-radius: 40px;
}
```
