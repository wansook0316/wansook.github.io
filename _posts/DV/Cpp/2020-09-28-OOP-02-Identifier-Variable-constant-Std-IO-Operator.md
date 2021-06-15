---
layout: post
title: "02: Identifier, Variable, constant, Std IO, Operator"
category: "DV/C++"
comments: true
tags: [c++, "OOP"]
feature-img: "assets/img/2.jpg"
feature-title:
use_math: true
series: "Object Oriented Programming"
summary: "Identifier, Variable, constant, Std IO, Operator C와 같은 특징을 알아본다."
---

# Identifier

![](https://user-images.githubusercontent.com/37871541/54508875-d89d1b00-498a-11e9-8cff-f1c3ffb86c44.png){: .center width="80%"}_Reserved Words(예약어)_

# 사용가능 문자

- ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_0123456789
- 예약어는 안된다.

# Variable Assignment

```c++
    #include <iostream>

    int main(){
        int x;		// 메모리에 integer 자료형을 넣을 공간만들고, 그 이름을 x라 하겠다.
    }
```

# Variable, Constant

C와 같으므로 [링크](https://egg-money.tistory.com/60?category=811216)로 대체하겠다.

# Standard Input & Output

기본적으로 `iostream` 헤더파일을 가져와서 사용한다. `iostream.h` 헤더 파일은, c++에 있는 입출력을 위한 헤더파일이다. C언어의 `stdio.h` 와 같은 역할을 한다.

## 출력 (cout)

```c++
  #include <iostream>

  int main(){
  std::cout << “Please enter two intger values: “;
  }
```

`namespace` 를 사용하면 다음과 같이 함수를 사용하는데 있어 `std::` 를 쓰지 않고 사용할 수 있다.

```c++
    #include <iostream>

    using namespace std;
    int main(){
        cout << “Please enter two intger values: “;
    }
```

## 입력 (cin)

```c++
  #include <iostream>

  int main(){
  std::cin >> value1 >> value2;
  }
```

여러개를 한번에 입력받을 수 있다. 마찬가지로, `namespace` 를 사용하면 다음과 같이 함수를 사용하는데 있어 `std::` 를 쓰지 않고 사용할 수 있다.

```c++
    #include <iostream>

    using namespace std;
    int main(){
        cin >> value1 >> value2;
    }
```

### 예제

```c++
  #include <iostream>
  using namespace std;
  int main() {
  int value1, value2, sum;
  cout << "Please enter two integer values: ";
  cin >> value1 >> value2;
  sum = value1 + value2;
  cout << value1 << " + " << value2 << " = " << sum << '\n';
  }
```

# Operator

마찬가지로 C와 같으므로 [링크](https://egg-money.tistory.com/63?category=811216)로 대체하겠다.
