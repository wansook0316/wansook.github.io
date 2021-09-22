---
layout: post
title: "02: Sugar API"
category: "DV/iOS"
comments: true
tags: [iOS, "RxSwift", "just", "from"]
feature-img: "assets/img/84.jpg"
feature-title: ""
use_math: true
series: "RxSwift"
summary: "이제 개념은 잡았으니, 편하게 사용하는 방법을 알아보자."
---

# 복습

* 왜 사용?
  * 비동기적으로 처리하는 데이터를 타입으로 리턴하기 위한 방법
  * 비동기적으로 생기는 데이터를 나중에생기는데이터 클래스 타입으로 감싸서 마치 데이터가 있는 것 마냥 타입으로 받는 것처럼 착각을 주게하는 방법
  * 실제 받아서 사용할 때 해당 동작이 발생한다.


# Sugar API

* 근데 앞의 코드를 보면 너무 사용법이 길다.
* 귀찮은 것을 없애주는 API를 알아보자.


## 그냥 하나의 데이터를 보내는 방법 (Just)

```swift
private func downloadJson(url: String) -> Observable<String?> {
        
    Observable.create { emitter in
        emitter.onNext("Hello")
        emitter.onCompleted()
        
        return Disposables.create()
    }
}
```

```swift
private func downloadJson(url: String) -> Observable<String?> {
    return Observable.just("hello")
}
```

* 이렇게 간단하게 보낼 수 있다.

## 요소를 하나씩 보내고 싶으면? (from)

* 만약에 두개를 보내고 싶으면?

```swift
private func downloadJson(url: String) -> Observable<String?> {
    return Observable.just(["hello", "world"])
}
```

* 이렇게 보내면 근데 배열 자체가 넘어가게 됨

```swift
private func downloadJson(url: String) -> Observable<String?> {
    return Observable.from(["hello", "world"])
}
```

* 이렇게 하면 요소 하나씩 onNext로 넘어간다.

## onNext만 받고 싶은 경우 (subscribe(onNext:))

```swift
_ = downloadJson(url: MEMBER_LIST_URL)
    .subscribe { [weak self] event in
        switch event {
        case .next(let json):
            DispatchQueue.main.async { [weak self] in
                self?.editView.text = json
                self?.setVisibleWithAnimation(self?.activityIndicator, false)
            }
        case .error(let error):
            print(error)
        case .completed:
            break
        }
    }
```

* 이렇게 계속 쓰는 것은 너무 불편하다.
* completed 된 경우나 error인 경우 할 동작이 없다면 이렇게 써도 된다.

```swift
_ = downloadJson(url: MEMBER_LIST_URL)
    .subscribe(onNext: {
        DispatchQueue.main.async { [weak self] in
            self?.editView.text = json
            self?.setVisibleWithAnimation(self?.activityIndicator, false)
        }
    })
```

* 이렇게만 사용하는 방법도 있다.
* `onComplted`, `onDisposed` 등등이 있다.


## 처리하는 스레드를 변경하는 방법 (.observeOn)

```swift
@IBAction func onLoad() {
    self.editView.text = ""
    self.setVisibleWithAnimation(self.activityIndicator, true)
    
    _ = downloadJson(url: MEMBER_LIST_URL)
        .subscribe(onNext: { json in
            DispatchQueue.main.async { [weak self] in
                self?.editView.text = json
                self?.setVisibleWithAnimation(self?.activityIndicator, false)
            }
        })
    
}
    
```

* 기존에는 UIupdate를 하기 때문에, URLSession을 수행하고 있는 스레드에서 main 스레드에서 업데이트를 진행하도록 dispatchQuee를 사용했다.

```swift
@IBAction func onLoad() {
    self.editView.text = ""
    self.setVisibleWithAnimation(self.activityIndicator, true)
    
    _ = downloadJson(url: MEMBER_LIST_URL)
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] json in
            self?.editView.text = json
                self?.setVisibleWithAnimation(self?.activityIndicator, false)
        })
    
}
    
```

* 이렇게 수행하는 동작의 스레드를 변경하여 작업할 수 있다.
* 이렇게 subscribe 데이터 처리 전에 다른 동작을 수행해주는 녀석들을 <mark style='background-color: #fff5b1'> Operator </mark> 라고 한다.
  * map, filter 등도 해당된다.

## Dispose 한번에 하기 (DisposeBag)

* 처리해야 하는 작업들의 dispose를 배열로 들고 있다가 viewWillDisappear시에 모두 dispose 하는 방법도 있다.
* 하지만 sugar api가 존재하는데, 

```swift
var disposeBag = DisposeBag()

func temp() {
    _ = downloadJson(url: MEMBER_LIST_URL)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] json in
                self?.editView.text = json
                self?.setVisibleWithAnimation(self?.activityIndicator, false)
            })

    self.disposeBag.insert(disp)
}
```

* 이렇게 해두면, 해당 VC안에 사용하는 변수로서 등록되기 때문에, VC가 Disappear되는 시점에 자동으로 bag안에 담긴 모든 disposable이 dispose된다.
* 이것도 싫다!

```swift
func temp() {
    _ = downloadJson(url: MEMBER_LIST_URL)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] json in
                self?.editView.text = json
                self?.setVisibleWithAnimation(self?.activityIndicator, false)
            })
            .disposed(by: self.disposableBag)
}
```

* 이렇게 간결하게 처리할 수도 있다.

# Marble Diagram 읽기

* Sugar API는 무지하게 많다.
* 함수의 종류가 엄청나게 많은 것처럼 엄청 많다.
* 이걸 외워서 사용할 수 없으니, 동작을 찾아서 적용해야 하는데, 이 때 설명하는 방식이 Marble Diagram이다.
* ObserveOn 함수의 예시를 보자.

![image](https://user-images.githubusercontent.com/37871541/134285034-19761b52-cd5f-40f4-866d-9ad5b2092a0a.png){: .center-small}_observeOn_

* 먼저 파란색 줄 위에 올라와 있는 데이터들은 Observable이다.
* 특정 연산자들은, raw Data를 Observable로 바꿔주는 역할을 수행하는데 ([from](http://reactivex.io/documentation/operators/from.html)) 이경우는 화살표위에 올라와 있지 않다.
* 아래의 박스는 Operator를 의미한다.
* 처음을 보면 일반적으로 시작하는 검은색 화살표가 아닌 파란색 화살표로 시작한다.
* 이 이유는 아래에 보면 보이는 `SubscribOn` 함수의 영향이다.
* ObserveOn 함수를 시작하면 Observable 객체들이 해당 operator가 지정하는 스레드에서 동작을 수행하게 되는데, 영어를 해석해보면, **이러한 스레드에서 관찰을 해줘** 라는 의미이다.
* 즉, 관찰하는 쪽(예를 들어 View) 에서 사용할 스레드를 변경할 때 사용한다.
* `SubscribOn`의 경우 어느 스레드에서 구독 작업을 시작할 것인지를 결정한다.
* 그래서 어느 시점에 해당 함수가 있는지에 상관없이 처음 작업을 실행하는 스레드가 파란색이 된 것을 볼 수 있다.



# Reference

* [시즌2 오프라인 모임](https://www.youtube.com/watch?v=iHKBNYMWd5I&t=3963s)
* [RxSwift+MVVM 4시간에 끝내기](https://github.com/iamchiwon/RxSwift_In_4_Hours)
* [ReactiveX](http://reactivex.io/)
* [ReactiveX Operators](http://reactivex.io/documentation/operators.html)
