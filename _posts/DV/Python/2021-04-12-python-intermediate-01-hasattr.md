---
layout: post
title: "01: hasattr/getattr/setattr"
category: "DV/Python"
comments: true
tags: [python, "Intermediate"]
feature-img: "assets/img/4.jpg"
feature-title: ""
use_math: true
series: "Python Intermediate"
summary: "변수가 있는지 확인해보자."
---

파이썬에서는 해당 객체에 method를 가지고 있는지 확인할 수 있는 문법이 있다. 간단하게 코드로 이해해보자.

```python
class cls:
    a = 1
    def b(self):
        pass

# cls에 b라는 멤버가 있는지 확인
>>> hasattr(cls, 'b')
True

# cls에서 a변수의 값 가져오기
>>> getattr(cls, 'a')
1

# cls의 a라는 변수에 값 9 설정하기
>>> setattr(cls, 'a', 9)
```