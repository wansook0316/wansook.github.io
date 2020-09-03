---
layout: post
title: "Safari: long line scroll 작동 안함"
category: "DV/HTML-CSS"
comments: true
tags: [Browser, Safari, css]
feature-img: "assets/img/20.jpg"
feature-title:
use_math: true
summary: "사파리에서 code block을 담당하는 pre 태그에서 long line scroll이 안되는 문제를 해결한다."
---

근본적인 문제는 Safari pre태그의 초기값 때문이다.
이것을 해결하기 위해서는 다음의 코드를 추가하면 된다.

```css
.site-content pre {
  overflow-wrap: normal;
}
```

### Reference

[참고](https://wordpress.org/support/topic/long-lines-do-not-scroll-in-code-block-when-using-macos-safari/)
