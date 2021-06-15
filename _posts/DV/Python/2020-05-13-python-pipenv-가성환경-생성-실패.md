---
layout: post
title: 가상 환경 생성 실패
category: "DV/Python"
comments: true
tags: [pipenv, python, trouble-shooting]
feature-img: "assets/img/31.jpg"
feature-title:
use_math: true
---

pipenv를 사용하다가 가상환경이 생성되지 않는 경우 해결책을 정리한다.

갑자기 가상환경 생성이 되지 않았다. 오류를 보니, python3 의 경로를 다른 것을 사용한다는 것을 알아냈다. 내가 원하는 python 버전으로 생성을 위해서는 해당 python의 설치 경로를 명시적으로 적어서 생성할 수 있다.

```bash
pipenv install --python /usr/local/bin/python3
```

### Reference

[github issue](https://github.com/pypa/pipenv/issues/4191)
