---
layout: post
title: "02: 레이아웃 잡기"
category: "DV/HTML-CSS"
comments: true
tags: [css, margin]
feature-img: "assets/img/10.jpg"
feature-title: ""
use_math: true
series: "HTML-CSS"
summary: "레이아웃 배치 팁을 배워보자."
---

# 배치

배치 잘못 잡으면 나중에 고통 받는다. 가장 쉬운 방법은 가로, 세로 순으로 보는 것이다. 이런 구분을 한뒤 감싸주는 것이 div 태그.

그런데 문제는, 이렇게 구역을 나눌 때마다 div 태그를 사용한다면 구분이 안된다. 예전에는 id를 사용해서 나눠줬다. html5가 오면서, 이렇게 계속 쓰다보니 아예 새로운 tag를 제안했다. 그것이 header, footer, nav, article, main. div태그에 이름이 달려있다는 것 빼고 차이는 없다. 아직은 검색엔진이 이러한 것을 반영하지 못하지만 사용하는 것이 좋다. 이런 것은 semantic tag라 한다.

# 정렬

사이트의 너비를 움직이면서 가운데 정렬이 어떤 구역인지 잡아주는 것이 중요하다. 가운데 정렬되는 구역을 정했다면, 그 영역을 div로 감싸준다. 그리고 이제 css를 사용한다. 이 부모 div의 속성을 변경하여 구역 자체를 가운데 정렬한다. 

```html
<header> <!-- header 자체는 width=100% -->
  <div id="header-center"> <!-- 가운데 정렬용 div -->
    <!-- 속성명: 속성값; 속성명2: 속성값2;  -->
    <!-- 인라인 스타일 : html 안에 적용하는 방식 권장 X-->
    <div>
      <span>네이버를 시작페이지로</span>
      <span>쥬니어네이버</span>
      <span>해피빈</span>
    </div>
    <div id="header-search">
      <h1>
        <a href="https://www.naver.com">네이버</a>
        <!-- 주석(comment)입니다 -->
        <!-- 속성(attribute)입니다 -->
      </h1>
      <h2>검색창</h2>
      <fieldset>
        <legend>검색</legend>
        <input />
        <button>검색</button>
      </fieldset>
    </div>
  </div>
</header>
```

# 선택자

inline style말고, css 파일을 가지고 사용하기 위해서는 해당 div 를 선택해야 한다. 이럴 떄 사용하는 것을 선택자라 한다.

```css
 /* div 중 header-center가 id인 경우*/
div#header-center {

}

/* div의 경우만 생략해서 적을 수 있다. */
#header-center {
  
}

/* 이런 경우 생략 불가 */
header#header {

}

/* 자식 선택자 */
#header-search > h1 {
    width: 280px;
    display: inline-block;
}

/* 자손 선택자 */
#header-center h1 {
  
}

```

보통은 자손 선택자를 많이 사용한다.


# html에게 알려주기

```html
<head>
    <meta charset="utf-8" />
    <title>네이버</title>
    <link rel="shortcut icon" type="image/x-icon" href="./favicon.ico" />
    <link rel="stylesheet" href="./naver.css">
</head>
```

알려줘야 먹는다.


# user agent stylesheet

브라우저가 기본적으로 특정 태그들에 대해서 정의해놓은 스타일을 말한다. 여러가지 브라우저에 따라 다른 스타일이 적용되어 있다. 이렇게 다양한 브라우저에 대해 잘 처리하는 것을 크로스 브라우징이라 한다.


# CSS (Cascading Style Sheet)

부모태그에 먹인 스타일은 자식태그에 먹힌다. 이름에서 부터 그 유래를 알 수 있는데, 폭포수를 의미하는 Cascade를 보면 아래로 적용된다는 것을 직관적으로 알 수 있다. 


# Display 속성

display: block 인 경우 너비 부분에 margin이 full로 찬다. 강제로 컨텐츠를 올릴 수는 있지만 일단은 그렇다. 나중에 position을 통해 할 수 있다. 이런 경우 inline-block을 주자.

하지만 이렇게 컨텐츠만 표기하고 싶은 경우는 span을 사용한다. 그런데 차이가 있다면 display가 inline이다. 이 두개의 차이점은 inline-block의 경우는 width, height를 지정해줄 수 있지만 inline은 그렇지 않다. 그래서 옵션이 있냐 없냐가 차이다.




