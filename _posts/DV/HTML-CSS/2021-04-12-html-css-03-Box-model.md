---
layout: post
title: "03: Box Model"
category: "DV/HTML-CSS"
comments: true
tags: [css, margin]
feature-img: "assets/img/10.jpg"
feature-title: ""
use_math: true
series: "HTML-CSS"
summary: "박스 모델에 대해 알아보자."
---

# 스크린 리더에서 읽힐 수 있는 display option

이전에서 말한 적이 있지만, 정보는 표현하되 사람 눈에 안보이게 하고 싶을 대 display: none을 사용했다. 하지만 이런 경우 스크린 리더도 읽지 못한다. 그래서 어떻게 해야하냐. 네이버 화면을 보게되면, `blind`라는 속성이 있다. 

```html
<h2 class="blind">바로가기</h2>
```

```css
.blind, .u_hc, .u_skip, .u_vc {
    position: absolute;
    clip: rect(0 0 0 0);
    width: 1px;
    height: 1px;
    margin: -1px;
    overflow: hidden;
}
```

이런 특화된 속성을 통해 트릭을 사용할 수 있다. 여기서  `.blind`는 css에서 클래스를 의미한다. id는 고유한 것, class는 군집하고 싶은 경우 사용한다. 또한 하나의 클래스를 여러군데에서 한번에 적용할 수 있다. 또한 하나의 태그에도 여러개의 클래스를 넣어서 사용할 수 있다.

사실 id도 여러개 할 수 있지만 보통 그렇게 사용한다. 유효하지 않은 html이기 때문에 이러한 규칙은 꼭 지키는 것이 좋다.

# 이미지 스프라이트

예전에는 여러개의 이미지를 불러올 수가 없었다. 네트워크 환경이 좋지 않았기 때문. 또한 여러개의 이미지를 불러올 경우 로딩이 느려진다는 단점도 있었다. 그래서 한번에 필요한 이미지를 불러오기를 바랐는데, 그것이 이미지 스프라이트이다. 

![이미지 스프라이트](https://user-images.githubusercontent.com/37871541/114511028-58813680-9c72-11eb-9fdd-6a1af1150410.png){: .center-verysmall }_출처 : https://m.blog.naver.com/PostView.nhn?blogId=pxkey&logNo=221251177798&proxyReferer=https:%2F%2Fwww.google.com%2F_

http2 프로토콜이 나오면서 이러한 부담은 조금 줄어들었다. 그런데도 여전히 이러한 방법을 사용하는 이유는 브라우저에서 모두 이러한 것을 지원하는 것은 아니기 때문이다. 그리고 만약에 페이지를 보여주는데 지나치게 많은 요청을 보내서 받아야 한다면 이러한 단점은 여전히 부각되게 된다. 그래서 이러한 테크닉을 알아두는 것이 도움이 된다. 프론트엔드 개발자로 성장하기 위해서는 로딩시간과 같은 것을 줄이는 것에 신경을 써줘야 성장할 수 있다.

그런데 그러면 어떻게 처리를 해서 사용해야 할까? 브라우저에서, CSS에서 그것이 가능하다.


## 이미지 스프라이트 처리

```css
#header-search h1 {
    width: 198px;
    height: 48px;
    display: inline-block;
    /*background-image: url(./sp_search.png);*/
    /*background-position: -4px -10px; background의 이미지가 맞지 않을 경우 위치를 조정해줌 */
    /*background-repeat: no-repeat;*/
    background: url(./sp_search.png) -4px -4px no-repeat; 
    vertical-align: middle;
    position: relative;
    top: -6px;
}
```


# border-box, content-box

기본적으로 css는 content, padding, border를 다른 것으로 친다. 그런데 이렇게 되면 내가 하고 싶은 건 border까지 포함한 width, height를 책정하고 싶은 것인데, 일일히 계산해야 한다. 그래서 다음과 같이 변경하여 사용한다.

```css
box-sizing: border-box;
```


# asterisk

모든 태그에 적용할 수 있는 태그이다. border-box같은 경우 모든 태그에 적용시키고 사용하는 것이 편한데, 이런 경우 적용하면 좋다.

```css
* {
  box-sizing: border-box;
}
```
# outline

input태그를 만들게 되면, focus가 자동으로 잡힌다. 이것을 없애고 싶으면

```css
  outline: none;
```

