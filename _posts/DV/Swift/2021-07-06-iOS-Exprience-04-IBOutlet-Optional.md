---
layout: post
title: "04: IBOutlet에서의 Optional"
category: "DV/Swift"
comments: true
tags: [iOS, "Optional", "IBOutlet", "Interface Builder"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "IBOutlet은 왜 기본 선언이 암시적 옵셔널인가?"
---



# IBOutlet에서의 Optional

* 암시적 옵셔널 `!`은 nil인 상태를 가질 수 있으나, 바인딩을 하지않고 접근이 가능하다.
* 옵셔널 `?`을 사용하여 선언하면 바인딩을 한 후에야 해당 변수에 접근이 가능하다.
* 스토리보드에서 ctrl을 누르고 코드에 넣으면 `!` 로 선언이 되어서 자동적으로 들어가게 된다.
* 인위적으로 `?`로 선언을 바꾸는 것과 어떤 차이가 있을까?

## 암시적 옵셔널의 경우


![image](https://user-images.githubusercontent.com/37871541/124613589-5a901580-deae-11eb-96c0-fd9cef67293d.png){: .center-verysmall}_기본 화면_

```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.textLabel.text = "반영 Text"
    }
}
```

* 현재 상황은 IBOutlet을 선언은 했지만, 실제 스토리보드의 뷰 인스턴스와 연결을 하지 않은 상태이다.
* 이런 상황에서 아래 코드를 보면, 뷰가 로드되고, 해당 변수에 접근을 하게 된다.
* 현재는 암시적 옵셔널이기 때문에 옵셔널 체이닝을 하지 않고도 해당 변수에 접근할 수 있다.
* 이 상태에서 빌드하면 어떻게 될까?

![image](https://user-images.githubusercontent.com/37871541/124613831-9cb95700-deae-11eb-9915-ab8295c24e3d.png){: .center-small}_Runtime Error_

* 당연히 런타임 에러다.
* 왜냐하면 뷰가 로드된 후에, 해당 label instance를 IBOutlet을 통해 연결하지 않았는데(nil인데) 변수에 접근하라 했으니 잘못된 접근을 한 것.
* 이런 경우 <mark style='background-color: #fff5b1'> 연결을 안했으니 연결해라. </mark> 라는 척도로써 작용할 수 있다.


## 옵셔널로 정의한 경우

<img width="432" alt="스크린샷 2021-07-06 오후 11 08 27" src="https://user-images.githubusercontent.com/37871541/124614332-14878180-deaf-11eb-937f-9e3c8ad8bd38.png">{: .center-verysmall}_런타임 문제 없음_

```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.textLabel?.text = "반영 Text"
    }
}
```


* 이번에는 옵셔널로 선언해보았다.
* 이 경우, 해당 변수에 접근하기 위해서는 <mark style='background-color: #fff5b1'> 옵셔널 체이닝 </mark>을 사용해야 한다.
* 옵셔널 체이닝의 정확한 동작방법은 다음 글에서 다루도록 하겠다.
* 일단 textLabel이 nil이기 때문에, 해당 구문이 실행되지 않는다.
* 그렇기 때문에 정상작동한다.
* 이 경우, <mark style='background-color: #fff5b1'> 개발자의 실수가 발생했고, QA에서도 발견을 못한 경우, 사용자가 크래시를 경험하지 않는다. </mark>는 점이 있다.


## 장단점 정리

* 암시적 옵셔널
  * 잘못된 뷰 인스턴스에 접근했을 경우, 런타임 에러가 난다.
  * 연결 여부를 확실히 개발 단계에서 알 수 있다.
  * QA 기간에 이런 오류를 발견할 가능성이 있다.
* 옵셔널
  * 런타임에 에러가 나지 않는다.
  * 하지만 기능이 동작하지 않는 앱을 사용자가 사용할 수 있다.
  * 앱이 크래시는 나지 않는다.

정답은 없다. 선택의 영역이다.


