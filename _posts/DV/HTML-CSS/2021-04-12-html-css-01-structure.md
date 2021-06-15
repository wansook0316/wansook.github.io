---
layout: post
title: "01: 구조 잡기"
category: "DV/HTML-CSS"
comments: true
tags: [css, margin]
feature-img: "assets/img/10.jpg"
feature-title: ""
use_math: true
series: "HTML-CSS"
summary: "구조에 대한 이해를 해보자."
---

# 태그 용어

* 부모태그 - 상위 태그
* 자식태그 - 부모 바로 밑에 있는 태그
* 손주태그 - 자식 아래 자식을 의미
* 자손태그 - 부모 밑에 있는 모든 태그 (자식 + 손자)
* 형제태그 - 같은 위계에 있는 태그

# Head

* 화면에 안보임
* 웹 페이지의 언어 설정 (meta charset)
* 웹 사이트에 대한 설명
* 웹 사이트에 대한 제목
* favicon
* 화면 이외의 부가적인 정보

# 화면
* 즐겨찾기 아래의 공간


# 여는 태그 닫는 태그
닫는 태그가 없는 경우가 있다. 이럴 경우 `<meta charset="utf-8" />` 과 같이 뒤에 `/`를 붙이는 습관을 갖는다. React, Vue같은 경우 굉장히 엄격하다. 안에 들어가는 내용이 없을 경우 보통 이렇게 쓴다. 

* meta
* input
* img
  * description

# heading tag

h1~h6는 중요도에 따라서 분류한다. 이러한 것이 중요한 이유는 웹 접근성 때문이다. Headings map 확장 프로그램을 설치하면 한번에 볼 수 있다. 또한 나중에 검색 로봇이 크롤링할 대 이런 부분을 반영할 것이기 때문에 중요하다.

웹 접근성 때문에, 일단 구역 별로 h태그를 써서 나눠둔 뒤에 나중에 css를 통해 block을 하는 것이 보다 좋은 방법이다. 스크린 리더 ( 시각장애인)를 통해 읽을 수 있도록 만들기 위한 것.  

