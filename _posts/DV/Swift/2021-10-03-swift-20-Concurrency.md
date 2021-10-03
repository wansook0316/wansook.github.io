---
layout: post
title: "20: Concurrency"
category: "DV/Swift"
comments: true
tags: [Swift, "Concurrency"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "Swift"
summary: "스위프트의 Concurrency에 대해서 읽어본다."
---

# 동시성

* 코어의 개수만듬 코드를 실행시킬 수 있다.
* 4코어면 4개의 코드를 병렬적으로 실행가능


# Async, Await

callback 함수 (Completion Handler)를 사용하면 코드의 읽기가 상당히 어려워짐

```swift
listPhotos(inGallery: "Summer Vacation") { photoNames in
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    downloadPhoto(named: name) { photo in
        show(photo)
    }
}
```
함수 자체의 응답이 비동기로 돌아가는 경우, 비동기 함수임을 명시할 수 있음



```swift
func listPhotos(inGallery name: String) async -> [String] {
    let result = // ... some asynchronous networking code ...
    return result
}
```

만약 에러까지 던지는 경우 아래와 같이 쓰면 된다.

```swift
func listPhotos(inGallery name: String) throws async -> [String] {
    let result = // ... some asynchronous networking code ...
    return result
}
```

이렇게 5.5버전 부터 async, await를 사용하면 아래와 같이 간결하게 표현 가능

```swift
let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]
let photo = await downloadPhoto(named: name)
show(photo)
```

* 실행 순서
  * await를 본다.
  * 함수를 호출한다.
  * 그리고 해당 코드의 실행을 대기한다. (suspend)
  * 현재 작업을 진행하는 스레드는 멈춰 있는 것이 아니고, 다른 동시성 코드를 실행시킨다.
    * 예를 들어 포토 갤러리 리스트를 업데이트 하는 것 같은.
  * 해당 작업이 끝나면 할당된다.
  * 다시 await 작업을 수행한다.
  * 반환 받고 보여준다.
* 이렇게 스레드를 일시정지 하고(await) 기다리는 행위를 yieling 이라고 함

# 비동기 시퀀스

```swift
import Foundation

let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}
```
* 위의 listPhotos 함수의 경우 비동기로 모든 요소를 다 만든다음에 리턴을 하게 된다.
* 그런데 비동기로 한 요소를 받았을 때마다 보내줄 수 도 있다.
* 위와 같이 AsyncSequence 프로토콜을 사용한 녀석을 사용하면 하나씩 보낼 수 있다.

# 병렬로 비동기 함수 호출하기

* 여러 비동기 함수를 호출한다음에 전체 결과를 만들고 반환하려면 이와 같이 쓸 수 있다.

```swift
let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])

let photos = [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

* 그런데 이렇게 되면 작업을 하나씩 (왜냐면 일시정지되니까) 하게되서 비효율적이다.
* 그래서 아래와 같은 방법을 사용할 수 있다.

```swift
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])

let photos = await [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

* 각각의 변수가 미래에 받아진다고 선언해두고, 다 받아진 경우 awiat를 가지고 확인한뒤 리턴한다.


# 작업과 작업 그룹

* 비동기 작업을 묶어서 관리가능
* 그리고 그 작업들의 우선 순위를 만들 수 있음
* 취소도 가능
* 계층 구조로 관리된다.
* 그래서 작업 그룹안에 작업들은 공통의 부모 작업을 가지게 되고
* 각각의 작업은 자식 작업을 가질 수 있다.
* 이렇게 구조적으로 작업을 명시할 수 있기 때문에 이를 `structed Concurrency`라 부른다.
* 당연히 이렇게 구조화된 작업을 잘 만드는 책임은 개발자에게 있다.


```swift
await withTaskGroup(of: Data.self) { taskGroup in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        taskGroup.addTask { await downloadPhoto(named: name) }
    }
}
```

* 하나의 큰 테스크 그룹을 만들고, 그 안에 다른 비동기 작업들을 걸어둘 수 있다.
* 이렇게 되면 내부에 있는 taskGroup 안에 다른 task 들이 들어가게 된다.
* 작업의 취소는 `canceled` 를 사용하여 처리하고 `isCanceled` 함수를 통해 확인할 수 있다.

# Actor

* 참조형
* 그런데, 그러면 비동기로 작업할 때, 그 뭐냐..그... 동시성 이슈가 발생할 수 있음
* 그런데 actor의 경우 여러 task의 코드가 같은 인스턴스에 상호작용하는 것을 안전하게 해줌
* 스레드 안전하다는 것

```swift
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}

```

* 클래스 선언하는 것과 비슷하다.

```swift
let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)
// Prints "25"
```

만약에 이렇게 만들었는데, 다른 객체에서 TemperastureLogger에 접근해서 작업을 수행하고 있다면, 이 코드는 당장 접근이 불가하고, 해당 작업이 끝난 이후에 접근해서 값을 가져올 수 있다.

만약에 이렇게 스레드 안전하게 안만들어두면 이와 같은 상황이 발생가능하다.


1. update 메서드 호출함
2. measurements 어레이를 업데이트함
3. 다른 스레드에서 max가 업데이트 되기전에 max 값을 읽음
4. max를 업데이트함

이런 행위를 actor isolation 이라 함



# Reference

* [Concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
