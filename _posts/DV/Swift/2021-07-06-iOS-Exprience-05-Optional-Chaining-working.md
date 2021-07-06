---
layout: post
title: "05: Optional Chaining의 동작 방법"
category: "DV/Swift"
comments: true
tags: [iOS, "Optional", "Optional chaining"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "옵셔널 체이닝은 어떻게 동작하는 걸까?"
---


# 옵셔널 체이닝의 동작 방법

코드를 짜면서, 옵셔널로 선언된 변수에 대해서는 바인딩을 통해 내부값을 꺼내서 사용하거나, 아니면 옵셔널 체이닝을 사용해서 처리했다. 그런데, 옵셔널 체이닝을 쓰면서 lhs, rhs의 개념으로 접근했다가, 조금 다르다는 것을 알았다.

```swift
import UIKit

var test1: UILabel? // 옵셔널 선언 후, 값을 넣지 않은 상태 : nil
var test2: UILabel? = UILabel() // 옵셔널 선언후 값을 넣은 상태

func sampleText() -> String {
    print("called sampleText Method")
    return "Sample Text"
}

test1?.text = sampleText()
test2?.text = sampleText()

print("result : test1 = \(test1?.text ?? "No Value")")
print("result : test2 = \(test2?.text ?? "No Value")")
```

나는 처음에 옵셔널 체이닝으로 위와 같은 코드가 있다면, `test1`의 경우 왼쪽이 nil이 되고, 오른쪽 값은 "Sample Text"이기 때문에 할당이 되지 않아서, 즉 지나쳐서 이전 글의 문제가 발생하지 않는다 생각했다.

하지만 완전히 오개념이었고, 위의 실행 결과는 다르게 나왔다.

```
called sampleText Method
result : test1 = No Value
result : test2 = Sample Text
```

만약 내가 맞았다면, `called sampleText Method`는 두번 호출되었어야 했다. 하지만 그렇지 않았다. 즉, 선언시 사용하는 `?`말고, 변수를 옵셔널 체이닝 하면서 사용하는 `?`의 경우, `if` 문과 비슷하게 작동한다.

즉, 만약 nil이면, 이후 구문을 아예 실행조차 하지 않는다. nil이 아닐 경우는 실행한다. 이 부분을 이해하기 위해서는 내부에서 `test1?.text = sampleText()` 와 같은 구문이 어떻게 해석되는지를 이해해야 한다.


위와 같은 구문은 실제로는 할당문처럼 보이지만, 내부적으로 해당 구문은 `test1.setText(return value of sampleText())` 와 같이 작동한다. 즉, 메서드를 호출한다는 것. 그럼 이 메서드를 호출할 때, `test1?`으로 되어 있을 경우, 해당 변수는 nil일 수 있어, 그러니까 nil이면 <mark style='background-color: #fff5b1'> 실행하지마. </mark> 가 되어버린다.

이런 동작방식을 갖고 있기 때문에 위와 같은 결과가 나온다. 앞으로 이 개념을 숙지하고 옵셔널 체이닝을 사용하도록 하자.