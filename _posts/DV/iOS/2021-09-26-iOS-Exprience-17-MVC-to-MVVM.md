---
layout: post
title: "17: MVC to MVVM"
category: "DV/iOS"
comments: true
tags: [iOS, "코드리뷰"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "MVVM이 대체 뭔지. 직관적으로 알아보자."
---

# 기존 코드

```swift
class ViewController: UIViewController {
    // MARK: - MODEL
    struct UtcTimeModel: Codable {
        let id: String
        let currentDateTime: String
        let utcOffset: String
        let isDayLightSavingsTime: Bool
        let dayOfTheWeek: String
        let timeZoneName: String
        let currentFileTime: Int
        let ordinalDate: String
        let serviceResponse: String?

        enum CodingKeys: String, CodingKey {
            case id = "$id"
            case currentDateTime
            case utcOffset
            case isDayLightSavingsTime
            case dayOfTheWeek
            case timeZoneName
            case currentFileTime
            case ordinalDate
            case serviceResponse
        }
    }

    // CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNow()
    }

    var currentDateTime = Date()

    private func updateDateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        datetimeLabel.text = formatter.string(from: currentDateTime)
    }

    private func fetchNow() {
        let url = "https://worldclockapi.com/api/json/utc/now"

        datetimeLabel.text = "Loading.."

        URLSession.shared.dataTask(with: URL(string: url)!) { [weak self] data, _, _ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: data) else { return }

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"

            guard let now = formatter.date(from: model.currentDateTime) else { return }

            self?.currentDateTime = now

            DispatchQueue.main.async {
                self?.updateDateTime()
            }
        }.resume()
    }

    // MARK: - VIEW
    @IBOutlet var datetimeLabel: UILabel!

    @IBAction func onYesterday() {
        guard let yesterday = Calendar.current.date(byAdding: .day,
                                                    value: -1,
                                                    to: currentDateTime) else {
            return
        }
        currentDateTime = yesterday
        updateDateTime()
    }

    @IBAction func onNow() {
        fetchNow()
    }

    @IBAction func onTomorrow() {
        guard let tomorrow = Calendar.current.date(byAdding: .day,
                                                   value: +1,
                                                   to: currentDateTime) else {
            return
        }
        currentDateTime = tomorrow
        updateDateTime()
    }
}

```

* 해당 코드는 API를 통해 현재 시간을 가져와서 보여주는 앱이다.
* 현재 VC에 모든 로직이 혼재되어 있는 상황인데, 이를 MVVM 구조로 변경할 것이다.


# 개념 이해

* 용어부터 제대로 이해해야 한다.
* 실제 클라이언트 개발에서 진행하는 방식은 이와 같다.
* 일단 서버에서 내려주는 날짜 데이터가 어떤 흐름으로 화면에 표시되는지 이해해보자.

```
ServerModel
: UtcTimeModel

Model
: Date

ViewModel
: String
```

* 이렇게 구분되는 이유는, 서버에 존재하는 data를 받아서 decode하고,
* decode된 모델을 내부적으로 사용하는 모델로 변환한 뒤,
* 실제 뷰에 보여지기 전단계에 다시 String으로 변환되게 되는데, 이 과정에서 Model이란 개념을 차용해서 구분해본 것
* 원래는 Model에서 변환을 거쳐서 보여주게되는데, 이 부분도 분리해서 화면 모델과 같은 개념으로 가지고 있는 것이 맞지 않나?
  * 이 것이 ViewModel의 시발점
* 그런데 사실 이 ServerModel이라는 개념은 서버 말고 DB에서 불러올 수도 있는 것
* 그래서 이 개념을 Entity라 칭하자.


```
Repository : 데이터 Fetch

-> Entity(Model)

Mapper: Entity로 부터 Model 제작

-> Model

Business Logic: 로직 수행

-> ViewModel(Model)

View

```


# Entity

```swift
//
//  Entity.swift
//  MVCtoMVVM
//
//  Created by 최완식 on 2021/09/26.
//

import Foundation

// MARK: - MODEL
struct UtcTimeModel: Codable {
    let id: String
    let currentDateTime: String
    let utcOffset: String
    let isDayLightSavingsTime: Bool
    let dayOfTheWeek: String
    let timeZoneName: String
    let currentFileTime: Int
    let ordinalDate: String
    let serviceResponse: String?

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case currentDateTime
        case utcOffset
        case isDayLightSavingsTime
        case dayOfTheWeek
        case timeZoneName
        case currentFileTime
        case ordinalDate
        case serviceResponse
    }
}

```

# Repository

```swift
//
//  Model.swift
//  MVCtoMVVM
//
//  Created by 최완식 on 2021/09/26.
//

import Foundation

struct Model {
    var currentDateTime: Date
}

```

# Model

```swift
//
//  Repository.swift
//  MVCtoMVVM
//
//  Created by 최완식 on 2021/09/26.
//

import Foundation

class Repository {
    func fetchNow(onCompleted: @escaping (UtcTimeModel) -> Void) {
        
        let url = "https://worldclockapi.com/api/json/utc/now"

        URLSession.shared.dataTask(with: URL(string: url)!) { data, _, _ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: data) else { return }
            
            onCompleted(model)

        }.resume()
    }

}
```

# Service

```swift
//
//  Logic.swift
//  MVCtoMVVM
//
//  Created by 최완식 on 2021/09/26.
//

import Foundation


// 비즈니스 로직을 처리
class Service {
    
    let repository = Repository() // 네트워크 통신해서 서버 모델로 변경
    
    var currentModel = Model(currentDateTime: Date())
    
    func fetchNow(onCompleted: @escaping (Model) -> Void) {
        
        self.repository.fetchNow { entity in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:nn'Z'"
            
            guard let now = formatter.date(from: entity.currentDateTime) else { return }
            
            onCompleted(Model(currentDateTime: now))
            
        }
    }
    
    func moveDay(day: Int) {
        guard let movedDay = Calendar.current.date(byAdding: .day,
                                                    value: day,
                                                    to: self.currentModel.currentDateTime) else {
            return
        }
        currentModel.currentDateTime = movedDay
    }
}

```

# View Model

```swift
//
//  ViewModel.swift
//  MVCtoMVVM
//
//  Created by 최완식 on 2021/09/26.
//

import Foundation

class ViewModel {
    
    let service = Service() // 비즈니스 로직
    
    var onUpdated: () -> Void = {}
    
    var dateTimeString: String = "Loading..."
    {
        willSet {
            self.dateTimeString = "Loading..."
        }
        didSet {
            self.onUpdated()
        }
    }
    
    func viewDidLoad() {
        self.service.fetchNow() { [weak self] model in
            guard let self = self else { return }
            self.dateToString(date: model.currentDateTime)
            self.onUpdated()
        }
    }
    
    func reload() {
        self.viewDidLoad()
    }
    
    func moveDay(day: Int) {
        service.moveDay(day: day) // 뷰 모델은 직접 모델과 소통할 수 있도록?
        self.dateToString(date: service.currentModel.currentDateTime) 
    }
    
    
    private func dateToString(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        dateTimeString = formatter.string(from: date)
    }

}

```

# View

```swift
//
//  ViewController.swift
//  MVCtoMVVM
//
//  Created by 최완식 on 2021/09/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var datetimeLabel: UILabel!
    
    let viewModel = ViewModel() // 뷰는 뷰모델을 소유함
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰모델에 바인딩만 해두는 것.
        self.viewModel.onUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.datetimeLabel.text = self?.viewModel.dateTimeString
            }
        }
        
        self.viewModel.viewDidLoad()
    }

    @IBAction func onYesterday() {
        self.viewModel.moveDay(day: -1)
    }

    @IBAction func onNow() {
        self.viewModel.reload()
    }

    @IBAction func onTomorrow() {
        self.viewModel.moveDay(day: +1)
    }
}

```


# 흐름 이해

View -> Binding 

View -> Action -> ViewModel -> Service -> Model -> Service -> ViewModel -> View


# Reference

* [MVVM 종결](https://github.com/iamchiwon/mvvm_final)
* [github code](https://github.com/wansook0316/MVCtoMVVM)