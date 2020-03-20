---
layout: post
title: span의 height는 block 속성이 아니다.
category: "DV/HTML"
comments: true
tags: [css, span, height, block]
feature-img: "assets/img/2.jpg"
feature-title:
use_math: true
---

text를 쓰는 데 있어 어떤 tag를 써야 하는지, 또 그랬을 때 문제는 무엇인지 알아보자.

## text는 span 태그에 넣어서 관리한다.

div안에 text를 넣으면 좋지 않다.  
이번에 겪은 문제로는 box-shadow가 먹지 않았다.

## 그렇다고 div에 있던 텍스트를 span으로 교체하면 문제가 생긴다.

span 태그는 기본적으로 inline 속성을 강하게 띈다.  
그렇기 때문에 다음 그림과 같이 margin을 먹였음에도 불구하고 내가 원하는 모양대로 속성이 먹히지 않는다.

<img width="301" alt="image" src="https://user-images.githubusercontent.com/37871541/77174622-b17caa80-6b04-11ea-909b-bb23189fff68.png">

## div와 span의 가장 큰 차이는 display: block, inline

따라서 만약에 다 뒤집어 엎고 교체하기 싫다면, display: block 속성을 추가해주면 된다.

# 결론

가장 좋은 방법은, text를 쓰는 공간에는 span을 써주고, 이 공간 자체를 box처럼 쓰고 싶다면 display block을 써주자.

또는 아예 box와 textbox를 구분해서 만들어주는 것도 좋은 방법이다.
