---
layout: post
title: "14: Gesture Recognizer"
category: "DV/Swift"
comments: true
tags: [iOS, "Gesture Recognizer"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "제스쳐 인식기에 대해서 알아보자."
---

# Gesture Recognizer

UIGestureRecognizer 클래스는 특정 제스처 인식기에 대한 동작을 정의한다. Delegate 객체를 활용하면, 일부 동작을 더욱 세밀하게 커스텀할 수 있다.

1. UITapGestureRecognizer : 싱글탭 또는 멀티탭 제스처
2. UIPinchGestureRecognizer : 핀치(Pinch) 제스처
3. UIRotationGestureRecognizer : 회전 제스처
4. UISwipeGestureRecognizer : 스와이프(swipe) 제스처
5. UIPanGestureRecognizer : 드래그(drag) 제스처
6. UIScreenEdgePanGestureRecognizer : 화면 가장자리 드래그 제스처
7. UILongPressGestureRecognizer : 롱프레스(long-press) 제스처

이와 같은 하위 클래스가 존재한다. 연결하는 방법은 다음과 같다.

* 제스처 인식기를 만든다.
  * target
  * action
  * 을 정의한다.
* 해당 제스처 인식기를 View에 연결한다.

이부분은 실습해보는 것이 더 확실하게 다가오기 때문에 많은 내용을 작성하지는 않겠다.

# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/20638/?isDesc=false)
* [UIKit UIGestureRecognizer](https://developer.apple.com/documentation/uikit/uigesturerecognizer)
* [H.I.G Gestures](https://developer.apple.com/design/human-interface-guidelines/ios/user-interaction/gestures/)

