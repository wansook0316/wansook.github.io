---
layout: post
title: window resize event
category: "DV/JavaScripts"
comments: true
tags: [development, javascript, resize]
feature-img: "assets/img/20.jpg"
feature-title:
use_math: true
---

자바스크립트의 window 이벤트를 알아본다.

## resize

```javascript
window.addEventListener("resize", changeContent);

function changeContent(event) {
  const cat = document.getElementById("js-cat");
  const cv = document.getElementById("category-cv");
  const math = document.getElementById("category-math");
  const ds = document.getElementById("category-ds");
  const cs = document.getElementById("category-cs");
  const dv = document.getElementById("category-dv");
  const about = document.getElementById("category-about");
  if (event.target.innerWidth < 710) {
    cv.innerText = "📜";
    math.innerText = "✖";
    ds.innerText = "📈";
    cs.innerText = "💾";
    dv.innerText = "📱";
    about.innerText = "😎";
    cat.style.justifyContent = "space-around";
  } else {
    cv.innerText = "CV";
    math.innerText = "Math";
    ds.innerText = "Data Science";
    cs.innerText = "Computer Science";
    dv.innerText = "Development";
    about.innerText = "About";
    cat.style.justifyContent = "center";
    console.log(cat);
  }
}
```

이 코드는 내 블로그 카테고리를 수정할 때 만든 코드이다.
