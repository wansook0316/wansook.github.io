---
layout: post
title: "13: XCTest"
category: "DV/iOS"
comments: true
tags: [iOS, "XCTest"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "XCTest란?"
---

# XCTest란?


# 함수

* 앞에 test로 시작해야 한다. 그렇지 않으면 Xcode가 잡지를 못한다.



# Target 설정

* 각각의 파일의 Target membership을 추가하는 방법으로 가능하다.


# Test 시 simulator 뜨지 않게 하는 방법

![image](https://user-images.githubusercontent.com/37871541/131937727-83f7901b-1918-4594-99b5-759e13c5c823.png){: .center}

1. 프로젝트
2. general
3. test Target
4. host application -> none으로 변경



# Error test

```swift
func test_로봇1개이상추가실패() {
    let playerManager = PlayerManager()
    var thrownError: Error?
    let robot1 = Player(type: .robot)
    let robot2 = Player(type: .robot)
    
    XCTAssertNoThrow(try playerManager.participate(player: robot1))
    XCTAssertThrowsError(try playerManager.participate(player: robot2)) {
        thrownError = $0
    }
    
    XCTAssertTrue(thrownError is PlayerManagerError, "잘못된 에러 타입 : \(type(of: thrownError))")
    
    XCTAssertEqual(thrownError as? PlayerManagerError, .CapacityFullError)
}
```

* 에러를 받는다.
* 에러의 타입을 확인한다.
* 에러의 케이스를 확인한다.