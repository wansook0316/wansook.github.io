---
layout: post
title: "03: Auto Layout"
category: "DV/Swift"
comments: true
tags: [iOS, "View hierarchy", "뷰 계층", "SuperView", "SubView", "Interface builder", "Frame", "Bounds"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "iOS의 View 체계를 알아보자."
---



# View의 기본적인 역할

* 화면에 앱 콘텐츠를 나타내기 위해 윈도우, 뷰를 사용
* 윈도우
  * 그 자체로 콘텐츠 표현은 어려움
  * 하지만 뷰를 위한 컨테이너 역할을 함
* 뷰
  * UIView Class의 인스턴스
  * UIView 클래스의 하위 클래스 인스턴스를 말함
  * 그런데 사실 내가 Custom하여 특정 클래스를 만들어 화면에 보이게 만들면 이것도 View임
  * UI를 구성하는 Class가 인스턴스화 된 것이 뷰라고 생각하는 것이 보다 옳음
  * Image, Text, 도형등 다양한 콘텐츠를 나타낼 수 있음
  * 뷰는 다른 뷰를 관리하고 구성하기 위해 사용되기도 함
  * `제스처 인식기`를 사용하거나 직접 터치 이벤츠를 처리할 수 있음
  * View 계층 구조에서 부모뷰는 자식뷰의 위치와 크기를 관리함


## 뷰 계층(View hierarchy)

### 뷰 계층 구조와 서브뷰 관리

* 내 컨텐츠 보여주기
* 다른 뷰(자식)를 위한 컨테이너로써의 역할
* 하나의 뷰가 다른 뷰를 포함하면, 부모-자식 관계 성립
* 슈퍼뷰, 서브뷰


![image](https://user-images.githubusercontent.com/37871541/122938829-0c5b1c80-d3ae-11eb-86ce-a2561fce49e2.png){: .center-small}_슈퍼뷰가 서브뷰에 의해 가려짐_

* 서브뷰가 불투명하면 가려진다.

![image](https://user-images.githubusercontent.com/37871541/122938992-2eed3580-d3ae-11eb-8800-8ac9dad7d22f.png){: .center-small}_반투명하면 살짝 보임_


* 뒤가 보여서 주황색이 됨

![image](https://user-images.githubusercontent.com/37871541/122942383-23e7d480-d3b1-11eb-9043-b3ae6a1a00ee.png){: .center-small}_같은 배열 안에 있을 경우 나중 서브뷰가 맨위에 보여짐_

* 슈퍼뷰는 서브뷰를 배열 안에 관리함
* 위와 같이 여러개의 서브뷰가 있을 경우, 겹쳐지게 된다면 가장 끝에 있는 서브뷰가 맨위에 보여짐

![image](https://user-images.githubusercontent.com/37871541/122942698-5c87ae00-d3b1-11eb-8ebf-3ebea9cd5423.png){: .center-small}_겹쳐지는 경우 영역에 따라 색이 다르게 보임_

* 두 개의 서브뷰가 모두 반투명할 경우 색이 섞여 화면에 보여짐



## 뷰 계층의 생성과 관리

* 생성
  * 인터페이스 빌더
  * 코드
    * `addSubView(_:)`
      * 이걸 사용하면 부모뷰 배열에 해당 서브뷰를 가장 마지막 목록에 추가함
    * `removeFromSuperView()`
      * 이 메서드를 사용하면 서브뷰를 제거할 수 있음
      * 서브뷰에서 실행하는 거겠지? 읽어보면 알 수 있다.
    * `insertSubView(_: at:)`
      * 서브뷰를 부모뷰 목록의 중간에 삽입
    * `bringSubView(toFront:)`, `sendSubView(toBack:)`

생성 관련해서 연습을 진행해야 한다. 해당 방법은 [여기]((https://www.boostcourse.org/mo326/lecture/16874/?isDesc=false))에서 진행할 수 있다. 실습이 제일 중요하다.

인터페이스 빌더인 스토리보드로 하는 것은 워낙 직관적이라, 코드로 하는 것만 첨부한다.

```swift

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 서브 뷰 생성
        let frame = CGRect(x: 60, y: 100, width: 240, height: 120)
        let subView = UIView(frame: frame)
        
        // 서브 뷰의 색상
        subView.backgroundColor = UIColor.green
        
        // 서브 뷰 추가하기
        view.addSubview(subView)
        
        // 서브 뷰 제거하기
        subView.removeFromSuperview()
    }
}
```

## 뷰의 좌표계


* 좌측 상단 모서리를 원점으로 함
* 아래쪽, 오른쪽으로 확장됨


### 프레임과 바운드


![image](https://user-images.githubusercontent.com/37871541/122949692-d4a4a280-d3b6-11eb-9c21-fb0e51cb8b64.png){: .center-small}_Frame and Bounds_

* Frame
  * 슈퍼뷰의 좌표계를 기준으로 크기와 위치를 나타냄
* Bounds
  * 자신의 좌표계를 기준으로 크기와 위치를 나타냄

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad")
        let viewRect = CGRect(x: 100, y: 100, width: 200, height: 200)
        let subView = UIView(frame: viewRect)
        subView.backgroundColor = UIColor.green
        
        print("서브뷰의 프레임 CGRect : \(subView.frame)")
        print("서브뷰의 바운드 CGRect : \(subView.bounds)")
        print("서브뷰의 프레임 Origin : \(subView.frame.origin)")
        print("서브뷰의 바운드 Origin : \(subView.bounds.origin)")
        
        self.view.addSubview(subView)
    }
}
```

```
서브뷰의 프레임 CGRect : (100.0, 100.0, 200.0, 200.0)
서브뷰의 바운드 CGRect : (0.0, 0.0, 200.0, 200.0)
서브뷰의 프레임 Origin : (100.0, 100.0)
서브뷰의 바운드 Origin : (0.0, 0.0)
```

* Frame은 부모뷰의 입장에서 알아야하는 정보
* Bounds는 자신의 입장에서 알아야하는 정보라 할 수 있다.


![image](https://user-images.githubusercontent.com/37871541/122960457-6368ed80-d3be-11eb-9d0c-284514ce31a4.png){: .center-small}_View의 사각형 정의위해 필요한 요소_

* View의 사각형을 정의하기 위해서는 위치, 크기가 필요하다.
* 위치를 나타내는 것은 origin
* 크기를 나타내는 것은 size이다.
* 각각의 origin과 size는 CGPoint, CGSize라는 구조체를 사용해서 나타낼 수 있다.
* 이 CGPoint, CGSize는 CGFloat라는 타입으로 나타내어진다.
* 또 이 두개의 구조체를 묶어서 CGRect이라는 구조체를 정의하는데, 이 구조체를 UIView의 인자로 바로 넣을 수 있다.


### Frame, Bounds 왜 필요한가?

* Frame
  * 부모뷰와 비교해서 뷰를 배치하는 경우
  * 즉 부모뷰에 대해서 현재 뷰의 위치를 결정해야 하는 경우
* Bounds
  * 나 자신의 좌표를 나타내는 것
  * 즉 Frame의 origin은 부모에 대해 뷰의 시작 위치를 나타내는 것이고
  * bounds의 origin은 그 절대 위치는 고정한 상태로, 해당 뷰에서의 나자신의 시작 위치를 결정짓는 것
  * 그렇기 때문에 A의 자식뷰인 B의 bounds의 origin을 (0, 0)에서 (30, 40)으로 이동했다면
  * B 내부에서 시작 위치가 0, 0에서 30, 40으로 변경되는 것
  * 만약 B의 이미지 크기가 기기 화면을 넘어가는 경우, 이렇게 bounds의 origin을 변경하게 되면
  * 이미지를 **스크롤**한 효과를 줄 수 있다.
  * 따라서 Bounds는 스크롤 뷰와 같은 기능을 구현할 때 필수적이라 할 수 있다.
  * 자세한 내용은 [여기](https://zeddios.tistory.com/203)를 참조하다.

# Reference
[View 이해 연습하기](https://www.boostcourse.org/mo326/lecture/16874/?isDesc=false)  
[iOS ) Frame과 Bounds의 차이 (1/2)](https://zeddios.tistory.com/203)