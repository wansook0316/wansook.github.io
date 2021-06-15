---
layout: post
title: opacity를 사용하여 display none animation 만들기
category: "DV/HTML-CSS"
comments: true
tags: [css, transition, opacity]
feature-img: "assets/img/20.jpg"
feature-title:
use_math: true
summary: "css를 사용하여 애니메이션 효과를 주는 법을 알아보자."
---

### Html

```html
<div class="chat__write--container">
  <input
    type="text"
    class="chat__write"
    placeholder="Send message"
    class="chat__write-input"
  />

  <div class="chat__icon-left chat__icon">
    <i class="far fa-plus-square"></i>
  </div>

  <div class="chat__icon-right chat__icon">
    <span class="chat__write-icon">
      <i class="far fa-smile-wink"></i>
    </span>
    <span class="chat__write-icon">
      <i class="fas fa-microphone"></i>
    </span>
  </div>
</div>
```

<center> <img width="479" alt="image" src="https://user-images.githubusercontent.com/37871541/77222536-76778700-6b97-11ea-868b-d8cd3f936b69.png"> </center>

위의 상황에서 문자를 보내는 것을 클릭했다고 생각해보자. 그 경우, 주변에 있는 아이콘이 사라졌으면 좋겠다. 그런데, 그 아이콘의 속성을 `display: none;`으로 할 경우, 애니메이션 효과를 넣을 수 없게 된다.

그래서 속성의 값중 실수 값을 가질 수 있으면서 같은 효과를 내는 `opacity` 속성을 사용한다.

### CSS

```css
.chat__write:focus ~ .chat__icon {
  opacity: 0;
}
.chat__icon {
  font-size: 23px;
  transition: opacity 0.5s ease-in-out;
}
```

여기서 ~ 선택자는, 형제 선택자이다.

## 중요

여기서, 중요한 것은, 내가 없애고 싶은 **아이콘은, input 태그 뒤에 있어야 한다는 점**이다. 만약 그렇지 않다면 애니메이션이 적용되지 않는다. 결과적으로 CSS로 어떤 효과를 주고 싶을 때는, **_내가 액션을 취할 태그를 html 문서의 앞에 적어주어야 동작_**한다.
