---
layout: post
title: "02: 코드리뷰 Part 1"
category: "DV/iOS"
comments: true
tags: [iOS, "코드리뷰"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "코드리뷰 정리 첫번째"
---

# PR/commit 방법

* 리소스를 추가하는 커밋과 코드 커밋을 분리한다.
* PR 제목은 구성된 커밋을 대표할 수 있는 제목으로 구성한다.
* 최대한 잘게 커밋하고, 이를 직관적으로 알 수 있는 커밋 제목을 선정
* 세부사항에는 어떠한 부분을 수정했는지 추가로 작성할 것


# 코드 작성 팁

* `//Mark: - description`을 사용해서 문서화
* 메서드 위에 `///`을 사용하게되면 자동완성할 때, 설명이 바로 밑에 노출됨
* Asset에 있는 `sound`와 같은 상수는 별도로 관리함

```swift
private enum Constants {
    static let audioResourceName: String = "sound"
}
```

* guard문 이후, 에러가 났을 때 log를 남기는 습관을 갖는다.
* 외부에 공개할 필요가 없는 메드면 private 키워드를 넣는 것이 원칙 (멤버변수, 멤버메서드)
  * `IBOutlet` 같은 경우도 마찬가지
  * `private` 키워드를 달지 않은 경우 외부에서 접근하여 뷰의 상태를 변경할 수 있으므로 특별한 경우가 아니면 `@IBOutlet private weak var`로 선언
* `import`시 알파벳 순서로 정렬한다.
* 델리게이트와 상속을 분리해서 작성한다.

```swift
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: AVAudioPlayerDelegate {
    // delegate code 작성
}
```

* 메서드, 프로퍼티 호출시에는 `self` 키워드를 붙이는 습관을 들인다.
* 에러 catch할 때는 보통 `catch` 키워드만 주로 사용
* 코딩 스타일을 꾸준하게 가져갈 것. 아니면 복붙했다고 생각함
* 코드를 한줄한줄 짤 때, 조금이라도 효율적이고 좋은 코드를 작성할 줄 알아야 함

```swift
guard let duration = self.player?.duration else { return }
guard let playerCurrentTime = self.player?.currentTime else { return }
```

내가 이렇게 짰는데, 실제로 self.player?를 두번 체크하고 있다. player가 없다면, 두가지 프로퍼티를 초기화할 필요자체가 없음.

```swift
guard let player = self.player else { return }

let duration = player.duration
let currentTime = player.currentTime
```

이렇게 변경한다.

* Default parameter를 사용하여 코드의 길이를 줄이는 방법을 사용한다.
* 

## 왜 상수관리에 struct 대신 enum을 쓰는가?
  * 사실 둘다 사용가능하다.

```swift
private struct Constants {
    static let audioResourceName: String = "sound"
}

private enum Constants {
    static let audioResourceName: String = "sound"
}

Constants.audioResourceName
```

일단 둘다 가능하긴 하다. 그런데, 애초에 이렇게 왜 관리하는지에 대해 이해해야 한다. 결국 상수를 관리하는 이유는, 순수하게 이름을 묶어서 편하게 사용하기 위함이다.

struct는 init을 가지고 있는 값타입이다. 그렇기 때문에, 위의 예시에서 인스턴스화가 가능하다.

```swift
let a = Constants()
```
이렇게 될 경우 Constants라는 인스턴스를 생성하게 된다. 이것은 해당 작업을 하는 목적에 어긋나는 행위이므로 좋지 않다.

반대로 enum은 생성자가 없다. 그렇기 때문에 인스턴스를 만드는 것이 불가능하다.

```swift
let a = Constants() // Error
```

그렇기 때문에 이러한 상수를 관리하는데 있어서 보통 `enum`을 많이 사용하게 된다.


