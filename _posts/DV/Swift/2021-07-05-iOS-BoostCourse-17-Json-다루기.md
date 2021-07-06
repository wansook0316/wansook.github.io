---
layout: post
title: "17: Json 다루기"
category: "DV/Swift"
comments: true
tags: [iOS, "Json"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "테이블 뷰에 대해서 알아보자."
---


# Codable

```swift
typealias Codable = Decodable & Encodable
```

* 스위프트 4에서 제공된 기능
* 인스턴스를 다른 데이터 형태로 변환
* 그 반대도 가능
* 스위프트 인스턴스를 다른 데이터 형태로 변환하는 것을 `Encodable`
* 그 반대를 `Decodable`
* 이 두개를 합한 타입을 Codable로 정의
* 이런 Codable은 서버 통신에서 유용하게 사용
* 만약 Json 형식으로 서버와 애플리케이션이 통신한다면 Codable을 사용할 수 있음

![image](https://user-images.githubusercontent.com/37871541/124465853-df0c6680-ddd0-11eb-9620-ba5180494493.png){: .center-small}

```swift
struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    var vantagePoints: [Coordinate]
    var metadate: [String:String]
    var website: URL?
}
```

* Coordinate, Landmark 타입의 인스턴스를 다른 데이터 형식으로 변환하고 싶다.
* 이런 경우 Codable 프로토콜을 준수하도록 선언하면 알아서 해준다.
* 스위프트의 기본 타입은 대부분 Codable 프로토콜을 준수한다.


## CodingKey

* 그런데, 기본적으로 구조체의 프로퍼티의 이름이 Json의 Key로 들어가게 된다.
* 이렇게 되길 원하지 않는 경우도 있다.
* 이럴 경우 `CodingKeys` 라는 이름의 열거형을 선언하고, CodingKey 프로토콜을 준수하도록 하면 해결

```swift
struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    var vantagePoints: [Coordinate]
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case foundingYear = "founding_date"
        case location
        case vantagePoints
    }
}
```


# JSONEncoder / JSONDecoder

* Swift4 버전 이전에는 JSONSerialization을 사용하여 JSON 타입 데이터 생성
* 이제는 Codable 프로토콜 사용


## JSONEncoder

instacne -> JSON

```swift
import Foundation

struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String?
}

let pear = GroceryProduct(name: "Pear", points: 250, description: "A ripe pear.")

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

do {
    let data = try encoder.encode(pear)
    print(String(data: data, encoding: .utf8)!)
} catch {
    print(error)
}

/* Prints:
 {
   "name" : "Pear",
   "points" : 250,
   "description" : "A ripe pear."
 }
*/
```

## JSONDecoder

```swift
import Foundation

struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String?
}

let json = """
    {
        "name": "Durian",
        "points": 600,
        "description": "A fruit with a distinctive scent."
    }
    """.data(using: String.Encoding.utf8)!

let decoder = JSONDecoder()

do {
    let product = try decoder.decode(GroceryProduct.self, from: json)
    print(product.name)
} catch {
    print(error)
}

```


# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/16893?isDesc=false)
* [Codable - Swift Standard Library](https://developer.apple.com/documentation/swift/codable)
* [Encodable - Swift Standard Library](https://developer.apple.com/documentation/swift/encodable)
* [Decodable - Swift Standard Library](https://developer.apple.com/documentation/swift/decodable)
* [CodingKey - Swift Standard Library](https://developer.apple.com/documentation/swift/codingkey)
* [Encoding and Decoding Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types)
* [JSONEncoder - Foundation](https://developer.apple.com/documentation/foundation/jsonencoder)
* [JSONDecoder - Foundation](https://developer.apple.com/documentation/foundation/jsondecoder)
* [Using JSON with Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/using_json_with_custom_types)