---
layout: post
title: "09: 화면 전환"
category: "DV/iOS"
comments: true
tags: [iOS, "Documents"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "화면 전환에 대해서 알아보자."
---


# 내비게이션 인터페이스

* 계층적 구조의 화면 전환을 위해 사용되는 **드릴 다운 인터페이스**이다.

![image](https://user-images.githubusercontent.com/37871541/123372527-af828080-d5be-11eb-978c-f41e7481e415.png){: .center-small}_Drill-down interface_

내비게이션 인터페이스는 내비게이션 컨트롤러를 사용해서 구현할 수 있다.


## 내비게이션 컨트롤러

* container view Controller이다.
* navigation stack을 사용하여 다른 뷰 컨트롤러를 관리한다.
* 이 내비게이션 스택에 들어가서, 콘텐츠를 나중에 보여주게되는 뷰 컨트롤러를 content view Controller라 한다.
* 내비게이션 컨트롤러는 두개의 뷰를 화면에 표시함
  * 위쪽에 있는 최상위 컨텐트 뷰 컨트롤러의 콘텐츠를 나타내는 뷰 (어디에 들어와 있는지)
  * 아래쪽에 있는 내비게이션 바 또는 툴바가 있다. 이건 내비게이션 컨트롤러가 직접 관리한다.
* 내비게이션 인터페이스의 변화에 따라 특정 액션을 동작하도록 하기 위해 내비게이션 델리게이트 객체를 사용할 수 있음

![image](https://user-images.githubusercontent.com/37871541/123373088-c2e21b80-d5bf-11eb-8d5d-1044ea9e72bf.png){: .center-small}_내비게이션 컨트롤러 뷰 설명_


## 내비게이션 스택

* 내비게이션 컨트롤러에 의해 관리되는 뷰 컨트롤러를 담는 배열
* 내비게이션 하는 걸 생각해보면 쭉 타고 들어갔다가, 가장 나중에 들어갔던 녀석부터 보여지면서 빠져나와야 한다.
* 그렇기 때문에 Stack이 적절.
* 일단 그러면 가장 먼저들어가는 것은 root view controller이다.
* 설정창 들어가면 가장 먼저 보이는 녀석
* 그렇기 때문에 이녀석은 pop될 수가 없다.

![image](https://user-images.githubusercontent.com/37871541/123373324-2e2bed80-d5c0-11eb-89ee-a45dd67ec2b2.png){: .center-small}_내비게이션 스택_


## 내비게이션 스택에서의 화면 이동

* Stack과 같이 push, pop하지만 일단 용어가 조금 다르다.
* UINaviationController 클래스의 메서드 또는 `Segue`를 사용해서 내비게이션 스택의 뷰 컨트롤러를 추가/삭제할 수 있음
* 또한 사용자 이벤트 (back 버튼, 스와이프) 등을 사용해서 최상위 뷰 컨트롤러를 삭제하고 아래 상위 콘텐츠를 보여줄 수 있음
* `Segue`는 향후 자세히 설명, 얘도 내부적으로는 결국 UINaviationController의 메서드를 사용함


### push

![image](https://user-images.githubusercontent.com/37871541/123373820-0be69f80-d5c1-11eb-8bf9-c6b590b0f904.png){: .center}_push 과정_

1. UIViewController 클래스는 실제로 내비게이션 스택에 **푸시될 때** 인스턴스가 생성됨
2. 가장 먼저 내비게이션 스택에 루트 뷰 컨트롤러만 들어가 있음
   * 그렇기 때문에 내비게이션 컨트롤러를 생성할 때 반드시 루트 뷰 컨트롤러가 설정되어있어야 함
3. `뷰 컨트롤러 1로 이동` 버튼을 누르면 ViewController1을 푸시함
   * 인스턴스가 생성되고, 내비게이션 스택에 추가됨
   * 가장 최상위 뷰 컨트롤러로써 화면에 보임
4. `뷰 컨트롤러 2로 이동`이라는 버튼을 통해 스택에 뷰 컨트롤러 2도 푸시한다.
   * 뷰 컨트롤러2의 인스턴스가 생성되고, 내비게이션 스택에 추가됨
   * 뷰 컨트롤러가 최상위 뷰 컨트롤러로 화면에 보임
   * 당연히 이전 뷰 컨트롤러는 삭제되어서는 안됨. 뒤로 못돌아감

### Pop

![image](https://user-images.githubusercontent.com/37871541/123374291-d7271800-d5c1-11eb-9085-c3e88aa5f5ec.png){: .center-small}_pop 과정_

1. 뷰 컨트롤러가 팜될 떄 생성된 UIViewController의 인스턴스는 다른 곳에서 참조되고 있지 않다면 메모리에서 해제됨
   * 스택에서도 삭제
2. `back` 버튼을 누르면 뷰 컨트롤러2가 pop됨
   * 뷰 컨트롤러2가 내비게이션 스택에서 삭제됨
   * 뷰 컨트롤러1이 최상위 뷰 컨트롤러가 됨. 화면에 보임
3. 다시 이작업을 반복함
   * 뷰 컨트롤러1가 내비게이션 스택에서 삭제됨
   * 루트 뷰 컨트롤러이 최상위 뷰 컨트롤러가 됨. 화면에 보임
   * 루트 뷰 컨트롤러기 때문에 back 버튼이 없다는 것을 확인할 수 있음


## UINavigationController Class

* 내비게이션 컨트롤러 생성

```swift
// 내비게이션 컨트롤러의 인스턴스를 생성하는 메서드입니다.
// 매개변수로 내비게이션 스택의 가장 아래에 있는 루트 뷰 컨트롤러가 될 뷰 컨트롤러를 넘겨줍니다.
init(rootViewController: UIViewController)
```

* 내비게이션 스택의 뷰 컨트롤러 접근

```swift
// 내비게이션 스택에 있는 최상위 뷰 컨트롤러에 접근하기 위한 프로퍼티입니다.
var topViewController: UIViewController?

// 현재 내비게이션 인터페이스에서 보이는 뷰와 관련된 뷰 컨트롤러에 접근하기 위한 프로퍼티입니다.
var visibleViewController: UIViewController?

// 내비게이션 스택에 특정 뷰 컨트롤러에 접근하기 위한 프로퍼티입니다.(루트 뷰 컨트롤러의 인덱스는 0 입니다.)
var viewController: [UIViewController]
```

* 내비게이션 스택의 푸시와 팝에 관한 메서드

```swift
// 내비게이션 스택에 뷰 컨트롤러를 푸시합니다.
// 푸시 된 뷰 컨트롤러는 최상위 뷰 컨트롤러로 화면에 표시됩니다.
func pushViewController(UIViewController, animated: Bool)

// 내비게이션 스택에 있는 최상위 뷰 컨트롤러를 팝합니다.
// 최상위 뷰 컨트롤러 아래에 있던 뷰 컨트롤러의 콘텐츠가 화면에 표시됩니다.
func popViewController(animated: Bool) -> UIViewController?

// 내비게이션 스택에서 루트 뷰 컨트롤러를 제외한 모든 뷰 컨트롤러를 팝합니다.
// 루트 뷰 컨트롤러가 최상위 뷰 컨트롤러가 됩니다.
// 삭제된 모든 뷰 컨트롤러의 배열이 반환됩니다.
func popToRootViewController(animated: Bool) -> [UIViewController]?

// 특정 뷰 컨트롤러가 내비게이션 스택에 최상위 뷰 컨트롤러가 되기 전까지 상위에 있는 뷰 컨트롤러들을 팝합니다.
func popToViewController(_ viewController: UIViewController, 
		animated: Bool) -> [UIViewController]?
```

## 내비게이션 인터페이스 구성하기

오토레이아웃, view와 같이 두가지 방식이 있다.

### 스토리 보드 사용하기

1. 스토리보드에서 내비게이션 컨트롤러에 포함할 뷰 컨트롤러를 선택
2. 메뉴에서 `Editor` - `Embed in` = `Navigation Controller`를 선택
3. 선택한 뷰 컨트롤러가 내비게이션 컨트롤러의 루트 뷰 컨드롤러가 됨
4. 또는 객체 라이브러리에서 드래그 드롭해도 됨

### 코드 작성하기

* 코드로 하게되면, 컨트롤러를 생성할 때 원하는 시점을 정할 수 있다.
  * 예를 들어 내비게이션 컨트롤러가 애플리케이션 윈도우(window)의 루트 뷰로서 역할을 하면, `applicationdidFinishLaunching` 메서드에 구현이 가능함

과정을 살펴보자.

1. 루트 뷰 컨트롤러가 될 뷰 컨트롤러를 생성
   * 뒤로가기 버튼이 없다.
2. `init(rootViewController: UIViewController)` 메서드를 통해 내비게이션 컨트롤러를 초기화하고 생성한다.
3. 내비게이션 컨트롤러를 윈도우의 루트 뷰 컨트롤러로 설정

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    // 루트 뷰 컨트롤러가 될 뷰 컨트롤러를 생성합니다.
    let rootViewController = UIViewController()
    // 위에서 생성한 뷰 컨트롤러로 내비게이션 컨트롤러를 생성합니다.
    let navigationController = UINavigationController(rootViewController: rootViewController)
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    // 윈도우의 루트 뷰 컨트롤러로 내비게이션 컨트롤러를 설정합니다.
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()
    
    return true
}
```

## 내비게이션 바의 구성

* 내비게이션 바는 내비게이션 컨트롤러에 의해 생성됨
* 내비게이션 바는 내비게이션 컨트롤러의 관리를 받는 모든 뷰 컨트롤러의 상단에 표시됨
* 최상위 뷰 컨트롤러가 변경될 때마다 내비게이션 컨트롤러는 내비게이션 바를 업데이트함


![image](https://user-images.githubusercontent.com/37871541/123376760-faec5d00-d5c5-11eb-9ab7-205fe99ded68.png){: .center-small}_내비게이션 바의 구성_

![image](https://user-images.githubusercontent.com/37871541/123376816-10fa1d80-d5c6-11eb-861d-d2b74feae091.png){: .center-small}_내비게이션 바의 구조_

* 내비게이션 바는 내비게이션 인터페이스에서 상단에 표시됨
* 내비게이션바는 내비게이션 아이템을 가질 수 있음
* 뷰 컨트롤러가 전환될 때마다 내비게이션바의 콘텐츠들이 바뀜
* 하지만 내비게이션바 자체는 내비게이션 컨트롤러가 관리하는 공통 객체임
* 내비게이션 바의 타이틀을 통해 현재 위치를 알 수 있음



# 모달

* 사용자의 이목을 끌기 위해 사용하는 화면 전환 기법
* 엄밀히 말하면 특정화면을 위로 띄우는(presenting) 방식
* 모달이 올라오고, 이를 사라지게하려면 선택을 해야함
  * 알림
* 그래서 귀찮기 때문에, 꼭 필요할 떄 사용함
* 내비게이션 인터페이스는 정보의 흐름을 표현하는 것, 얘는 이목을 끌어야 하는 상황에서 팍 올라오는 것
* 꼭 처리를 해줘야 되기 때문에 빠르게 처리할 수 있는 내용을 표현

## 화면에 보이게 하는 방법

* 컨테이너 뷰에 임베딩
* 프레젠테이션 사용
  * View Controller의 나타내기(present) 기능은 UIViewController에 내장되어 있음
  * 모든 뷰 컨트롤러 객체에서 사용가능
  * present 기능을 사용하면, presenting하는 뷰컨트롤러와 presented되는 뷰컨트롤러 간의 관계 형성
  * presented 뷰컨트롤러가 사라질 때까지 이 관계는 유지됨


이하 내용이 너무 방대하여 코드를 치면서 이해하는 것이 빠르다 생각됨

# 핵심


* 내비게이션 인터페이스
  * 정보의 흐름이 연결될 때, 깊이를 가지고 있을 때
  * 설정 화면
  * push, pop
* 모달
  * 흐름 필요없이, 팝업, 간단한 정보를 보고 싶다.
  * 입력폼
  * 모달 띄우기 : present
  * 모달 닫기 : dismiss
* 이게 별거 아닌 것 같지만, 은연중에 우리는 이러한 것들을 습득했음
* 그래서 이러한 관습에 벗어나게되면 사용자는 이상함을 느낌


* [모달이란?](https://www.boostcourse.org/mo326/lecture/16880/?isDesc=false)


# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/20638/?isDesc=false)
* [Navifation](https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/navigation/)
* [Navigation Controllers](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Chapters/NavigationControllers.html)
* [UINavigationBar](https://developer.apple.com/documentation/uikit/uinavigationbar)
* [모달이란?](https://www.boostcourse.org/mo326/lecture/16880/?isDesc=false)
