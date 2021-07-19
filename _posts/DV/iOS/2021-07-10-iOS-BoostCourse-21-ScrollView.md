---
layout: post
title: "21: SchrollView"
category: "DV/iOS"
comments: true
tags: [iOS, "SchrollView"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "SchrollView에 대해서 알아보자."
---

# SchrollView

* 스크롤 뷰안에 포함된 뷰를 상하좌우로 스크롤 할 수 있고, 확대 및 축소할 수 있는 뷰
* 이를 상속받는 뷰로는 UITableView, UICollectionView, UITextView등이 있음
* 사진 확대후 그대그하는 그런 필요
* 줌, 줌아웃, 드래그 해서 원하는 곳을 볼 수 있게 해야 함
* 스크린 안에 fit하게 맞지 않지만 보여질 필요가 있는 경우에 필요하다.


![image](https://user-images.githubusercontent.com/37871541/125149860-8c3b0200-e176-11eb-97e5-2d8ef72dee2c.png){: .center-verysmall}




* 스크롤뷰는 다른 뷰와 다르게, 처음에 오토레이아웃을 잡게되면, 제대로 잡히지 않는다.
* 그 이유는 스크롤 뷰는 내부에 존재하는 View의 크기에 따라 해당 뷰의 크기가 변하기 때문이다.
* 일단 이를 해결하기 위해서는 스크롤 뷰 안에 내가 보여줄 서브뷰들을 담아줄 Container 뷰를 만들어 준다.
* 그리고 이 Container뷰와 ScrollerView간의 관계를 잡아준다
* 이 관계는 `content view guideline`과 `frame view guideline`이 있다.
* 먼저 보여줄 컨텐츠의 뷰를 설정하기 위해 ctrl을 누르고 해당 옵션에 드래그하여 맞춰준다.
* 그리고 frame view를 맞춰주는데, 이건 내가 어떻게 보여줄 것이냐에 따라 내부 container의 뷰의 크기가 달라진다. 만약 스크롤만 한다면 equal width가 될 것.
* 그리고 나서 container뷰 안에 내가 넣은 subview들을 정의해주면 된다.
* 이 때, auto layout으로 height에 대해서 제약을 크게 걸어서 작업한뒤, 해당 제약을 제거하는 방법으로 할 경우 쉽게 작업이 가능하다.


# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/16898/?isDesc=false)
* [UIScrollView](https://developer.apple.com/documentation/uikit/uiscrollview)
* [UIScrollViewDelegate](https://developer.apple.com/documentation/uikit/uiscrollviewdelegate)
* [About Scroll View Programming](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/UIScrollView_pg/Introduction/Introduction.html)
* [스크롤뷰 오토레이아웃](https://www.youtube.com/watch?v=MXJffcoWRlw)
