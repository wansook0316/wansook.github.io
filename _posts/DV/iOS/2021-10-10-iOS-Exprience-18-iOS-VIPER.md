---
layout: post
title: "18: VIPER"
category: "DV/iOS"
comments: true
tags: [iOS, "코드리뷰"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "디자인 패턴 중 VIPER에 대해서 알아보자."
---

# 좋은 아키텍쳐의 조건
1. 역할의 분배
   - SOLID의 Single Responsibility
2. 테스트가 가능한가?
3. 사용하기 쉬운가?
4. 단반향의 데이터 흐름을 가지는가?


이를 모두 만족하는 아키텍쳐는 있지 않다. 특정 부분에 이런 부분을 적용할 수 있고, 전체적으로 적용할 수도 있다. MVC는 모두 알테니, 간단한 흐름을 알기 위해 MVP 부터 생각해보자.


# MVP

```swift
import UIKit
import PlaygroundSupport

struct Person { // Model
    let firstName:String
    let lastName:String
}

protocol GreetingView:class { // View Protocol
    func setGreeting(greeting:String)
}

protocol GreetingViewPresenter { // Presenter Protocol
    init(view: GreetingView, person: Person)
    func showGreeting()
}

class GreetingPresenter : GreetingViewPresenter { // Presenter
    weak var view: GreetingView?
    let person: Person

    required init(view: GreetingView, person: Person) {
        self.view = view
        self.person = person
    }
    // 3.
    func showGreeting() { // Update View
        let greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
        self.view?.setGreeting(greeting: greeting)
    }
}

class GreetingViewController : UIViewController, GreetingView { // View
    var presenter: GreetingViewPresenter!
    ...
    // Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        setupLayout()
        self.showGreetingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    ...
    // Layout Code
    // 2. 
    @objc func didTapButton(button: UIButton) {
        self.presenter.showGreeting()  // Send Action to Presenter
    }
    // 1.
    func setGreeting(greeting: String) {
        self.greetingLabel.text = greeting
    }
    // layout code goes here
}
// Present the view controller in the Live View window
// Assembling of MVP
let model = Person(firstName: "Wasin", lastName: "Thonkaew")
let view = GreetingViewController()
let presenter = GreetingPresenter(view: view, person: model)
view.presenter = presenter

PlaygroundPage.current.liveView = view

```

핵심만 짚어보도록 하겠다.

1. Presenter는 모델을 소유한다.
   * VC는 약한 참조로 소유한다.
2. VC는 Presenter를 소유한다.
3. 각각의 객체를 연결하는데 있어서는 Protocol을 사용하여 연결을 끊는다.


이게 모든 핵심이다. 특이한 점은, 버튼을 눌렀을 떄 Action을 Presenter에게 보내고, 이 Presenter가 view에서의 행동을 요청한다는 점이다.

## 짚어야 할 점
* 여기서 귀찮은 점은, 버튼이 눌렸을 때, 발생하는 동작을 코드로 일일히 적어주어야 한다는 점이다.
* 또 결국 Presenter가 View와 Model을 참조하고 있다는 점이다.

## 좋은 아키텍쳐인가?

* 분배 여부
  * 기존의 Model과 View가 혼재된 상황을 정리함
* 테스트
  * 뷰와 분리되어 로직을 테스트할 수 있음
* 사용하기 편한가
  * 일단 코드길이는 더 길어짐.
* 단방향성
  * 일단 Presnter가 View, Model에 대해서 모두 참조하기 때문에 단방향성이라 보긴 어렵다.


# MVVM

위에서 공부해본 결과, Presenter는, View의 액션을 받았을 때, 해당 로직을 처리하고 View에 있는 내부 함수를 호출하여 업데이트 하는 방식을 사용한다. 이런 생각을 해볼 수 있지 않을까?

* View는 Presenter와 같은 녀석에게 요청만한다.
* Presnter는 사용하는 모델에게 요청한다.
* 모델의 값이 변하면!
  * 이 변하는 걸 감지해서, View까지 드르를 변화해서 화면이 감지한다.

즉, 여기서 말하고 싶은 건, 요청은 Model쪽으로 순차적으로 가되, 업데이트는 어떠한 흐름으로 처리하자는 것.

이것을 하기 위해서는 Observing이 필요하다. Observing 방법에는 여러가지가 있을 수 있다.

* KVO
* Reactive Programming
* Delegate
* Notification
* Property Observer (didSet)

이전에 나는 Closure를 사용하고 Property Observer를 통해 이러한 부분을 구현해본 적이 있다. 하지만, 굉장히 쓸데없는 코드가 중복되는 듯한 느낌이 들었다. 그렇기에 Reactive Framework를 쓰는 것이 보다 좋다.

![image](https://user-images.githubusercontent.com/37871541/136689086-68d2b46a-3de7-4cc0-a3af-a17cbcb95a2c.png){: .center-small}_MVVM_

## ViewModel

```swift
let apiService: APIServiceProtocol

//MARK: Initializer
init( apiService: APIServiceProtocol = APIService()) {
    self.apiService = apiService
}

...
// Activity Indicator
var isLoading: Bool = false {
    didSet{
        // notify
        self.updateLoadingStatus?()
    }
}
// Table View
private var cellViewModels:[PhotoListCellViewModel] = [PhotoListCellViewModel]() {
    didSet{
        // notify
        self.reloadTableViewClosure?()
    }
}
// Number of cells
var numberOfCells: Int {
    return cellViewModels.count
}

//MARK: Binding Closures
var reloadTableViewClosure: (()->())?
var updateLoadingStatus: (()->())?
...

// Request Data
func requestFetchData(){
    self.isLoading = true // trigger activity indicator startAnimating
    apiService.fetchPopularPhoto { [weak self] (success, photos, error) in
        // Compelete Fetching Data
        self?.isLoading = false // trigger activity indicator stopAnimating
        if let error = error {
            self?.alertMessage = error.rawValue
        }else {
            self?.processFetchedPhoto(photos: photos)
        }
    }
}
// Generate cell's ViewModel
private func processFetchedPhoto( photos: [Photo] ) {
    self.photos = photos // Cache
    var viewModels = [PhotoListCellViewModel]() // TableViewCellViewModel
    photos.forEach({viewModels.append(createCellViewModel(photo: $0))})
    self.cellViewModels = viewModels // trigger photoListTableView reloadData
}

// Get Cell
func getCellViewModel( at indexPath: IndexPath ) -> PhotoListCellViewModel {
    return cellViewModels[indexPath.row]
}

```

핵심만 설명해보겠다.

1. ViewModel은 모델을 소유한다. 혹은 데이터를 요청한다.
2. 데이터를 받으면, 화면에 뿌려질 ViewModel 객체로 만들고 이를 내부 변수에 설정한다.
3. 설정이 되면, ViewController에서 저장해둔, 클로저 코드가 실행된다.

여기서 핵심은, VC는 잘모르겠지만, ViewModel에게 야, 업데이트되면 이 코드를 실행해줘야해 나는 잘 모르겠고 니가 알아서 해봐. 라는 식으로 클로저 코드를 전달해주고, ViewModel은 알겠어, 한 뒤에 모델하고 우짜게 통신을 하고, 로직이 처리된 시점에 해당 코드를 호출한다.

이 때, Combine이나, Rx를 사용하면 보다 좋은 흐름으로 해당 작업을 할 수 있다.

* [내가 만든 ViewModel 코드](https://github.com/wansook0316/swift-p3-onban/tree/S058)

위의 링크는 자체적으로 만든 ViewModel 코드이다. Presenter라 해 두었지만, 보다 VIewModel에 가까운 듯 하다.


# VIPER
* VIPER는 쉽게 생각해보면 쉽다.
* 잘 생각해보면 MVVM의 문제가 무엇일까?
* 만약에 저렇게 간단한 구조라면, ViewModel이 하는 일이 너무 많다.
  * Model과의 로직 담당
  * 특정 Action에 대한 화면 전환 로직 (로직 수행후, VC에 있는 함수 호출)
  * Server 통신
  * 데이터 베이스에서 정보 가져오기 등..
* Presenter에서 ViewModel로 오면서, View를 업데이트 하는데 있어 보다 깔끔한 방식을 차용하긴 했지만, 여전히 역할이 비대하기는 마찬가지이다.
* 그러면 어떻게 해결할까? 
* 역할을 나누면 되지!

![image](https://user-images.githubusercontent.com/37871541/136689454-112bfbf0-e775-4af1-bb70-124dd3dd3dc3.png){: .center-small}_VIPER_

* 자 쉽게! 항상 개념은 쉽다! 어렵게 생각해서 어려운거지
* 여기서 Presenter, Router, Interacter가 ViewModel에 있던 녀석인데 분리했다.
* 끝이다.
* 역할
  * Presenter
    * 결과를 받아서, 화면에 보여줄 형식으로 변환한뒤 값에 세팅한다.
      * 세팅하면 자동적으로 View에 바인딩된 코드가 실행되서 화면 업데이트
  * Router
    * 화면 이동에 관한 로직이 들어있다.
    * 원래 화면 이동도 VC에서 처리하거나(MVC) Presenter 혹은 ViewModel이 처리했는데, 이 부분을 분리했다.
    * 방법은, VC에서 self로 인자를 넘긴 뒤, 처리만 Router에서 하는 것.
  * Interacter
    * 모델을 사용하는 Usecase를 담당
    * Server 통신
    * 내부 DB 통신
  * View
    * View Controller 포함
  * Entity
    * 모델을 말하는 것

핵심! 그냥 ViewModel이 하는 역할을 분리했다.

단점은 뭘까? 당연히 필요없는 함수들이 많이 발생한다는 것, 그리고, 사이사이를 Protocol로 연결해서 보통 사용하게 되서 많이 귀찮다. 라이브러리를 사용해서 간단하게 처리할 수 있을 것 같다.

그리고, 이걸 공부하다보니, 그렇다면 씬 별로 로직을 관리할 수 있을 것 같다는 생각이 들었다. 협업을 할 때 매우 효과적일 듯 하다.


* 갑자기 생각나서 추가
  * clean Architecture에서 보면, View -> Controller -> Usecase -> Entity -> Usecase -> presnter -> View와 같은 흐름으로 가는데, 일단 지금 하는 것 에서는 ViewModel이나 presenter가 Controller 역할을 같이하고 있다.
  * 만약 View에서 응답이 왔을 때, 이를 처리해야 하는 Interactr가 다르다면, Controller 객체가 View의 Action을 처리하고, 이를 받는 객체는 ViewModel 혹은 Presnter가 처리하는 방법이 있을 수 있겠다.
  * 대부분의 아키텍쳐는 이 흐름을 기반으로 해서 만들어 진것들이 많다. 이부분도 숙지할 것

# RIBs

* Uber에서 사용하는 방법
* Router, Interacter, Builder로 나뉜다,
* 쫄지 말자. 아마 개념은 간단할 거야.
* 크로스 플랫폼. 그래서 [github](https://github.com/uber/RIBs) 들어가보면 둘다 지원한다.


## VIPER의 문제점

* 생각해보자. VIPER의 문제점이 무엇일까?
* 잘 생각해보면, VC에서 Presenter를 가지고 있고,
* Presenter는 Router, Interacter를 가지고 있다.
* Interacter는 Entity를 가지고 있다.
* 이게 문제다.
* 엥? 뭐가 문제??
* 내가 생각하는 문제점은 두가지다.
  1. 의존성 주입으로 생성되기 어렵다.
  2. View에 의존적이다. View가 시작점이 되는 구조다.
* 결국 핵심이 되는 비즈니스 로직이 View로부터 출발해서 생성된다.
* 이게 가장 큰 문제점!

## 어떻게 해결할까?

* 일단 앱의 구조에 대해서 생각해보자.
* 특정 씬의 생성은, 이전 씬의 상태에 따라 달라진다.
* 예를 들어서 로그인을 한 상태와, 그렇지 않은 상태에 보여지는 화면이 달라질 수 있다.
  * 그리고 그 화면에는 로직까지 필요하다.
  * 이러한 것을 화면을 기준으로 생각하는 것은 사실 좋지 않다.
* 그래서 우버는 이런 씬에 관한 정보를 생성하는 객체를 하나 만들었다. 이게 Builder
  * 그러면 Builder는 내부에서 Interacter, Router, Presenter(Optional), View(Optional)을 생성한다.
  * Component는, 다른 Builder로 넘어갈때 필요한 정보를 넘겨주는 역할을 한다.
* 이렇게 되면 Builder사이의 계층구조를 관리하기가 편해진다.

![image](https://user-images.githubusercontent.com/37871541/136690999-7bff272d-1cf1-48f2-9d31-238aa1dc8376.png).{: .center}
![image](https://user-images.githubusercontent.com/37871541/136691007-6dd48fdc-377e-4427-8112-cb236407c5fb.png).{: .center}

* 이렇게 되면, View에 상관 없이 로직의 계층구조를 만들 수 있다.
* 또한 DI도 만족하게 할 수 있다.
* 프로토콜 지향 프로그래밍(VIPER에서도 사실 가능)을 강제한다.
* View가 없는 비즈니스 로직만 있는 것도 생성할 수 있다.

![image](https://github.com/uber/ribs/raw/assets/documentation/state.gif).{: .center}

## 역할
그렇다면, 이제 역할을 알아봐야겠지?

![image](http://1fykyq3mdn5r21tpna3wkdyi-wpengine.netdna-ssl.com/wp-content/uploads/2016/12/riblet_comms.png).{: .center}


* Interacter
  * 라우팅 요청을 수행
  * Presenter로 데이터 보냄
* Router
  * 자식 Ribs를 붙이고, 떼는 역할을 수행해서, 트리구조를 형성함
* Presnter
  * ViewModel로 View에 보냄
  * 혹은 binding으로 처리할 수도 있음
* View
  * 그리기만 함

일단은 이정도 까지만 알아보자! VIPER를 적용해보고 다시 프레임 워크를 공부해보는 걸로!

# Reference
* [iOS Architecture](https://github.com/protocorn93/iOS-Architecture)
* [VIPER](https://www.objc.io/issues/13-architecture/viper/)
* [VIPER2](https://medium.com/cr8resume/viper-architecture-for-ios-project-with-simple-demo-example-7a07321dbd29)
* [VIPER DEMO](https://github.com/jazzbpn/VIPER-DEMO/blob/master/VIPER-demo/app-modules/notice-module/router/NoticeRouter.swift)
* [RIBs](https://github.com/uber/RIBs)