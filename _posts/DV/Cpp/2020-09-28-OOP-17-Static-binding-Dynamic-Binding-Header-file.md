---
layout: post
title: "17: Static Binding, Dynamic Binding, Header File"
category: "DV/C++"
comments: true
tags: [c++, "OOP"]
feature-img: "assets/img/2.jpg"
feature-title:
use_math: true
series: "Object Oriented Programming"
summary: "정적 바인딩, 동적 바인딩, 헤더파일에 대해 알아본다."
---

# Static Binding (정적 바인딩)

```c++
#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Base{
public:
    void f(){cout << "Base::f()" << endl;}
    virtual void vf() {cout << "Base::vf()" << endl;}
};

class Derived:public Base{
public:
    void f(){ cout << "Derived::f()" << endl;}
    void vf() override { cout << "Derived::vf()" << endl;}
};


int main(){
    Base base;
    Derived derived;

    base.f();
    base.vf();
    derived.f();
    derived.vf();

    return 0;
}

```

```
Base::f()
Base::vf()
Derived::f()
Derived::vf()
Program ended with exit code: 0
```

우리가 여태껏 배웠던 상속에서 `override` , `virtual` 은 단지 상속을 받았다는 것을 명시하는 역할이라고 생각했다. 이렇게 우리가 알았던 상속을 단순하게 사용하는 방법을 **정적 바인딩** 이라 한다.

코드를 보면, 내가 생성한 객체에 대해 엮여있는 함수를 정해주는데 있어 내가 선언해준대로 되었다. base 객체에 대해 base 클래스에서 정의된 멤버함수들만 사용가능하고, derived 객체에 대해서는 Derived 클래스에서 정의된 멤버함수들만 사용가능하다.

# Dynamic Binding (동적 바인딩)

그런데, 우리가 두 클래스가 상속관계에 있다는 것을 안다면, 이 멤버함수를 자동으로 묶어줄 수는 없을까? 이제 `override` , `virtual` 의 강력한 기능을 알 수 있다.

```c++
#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Base{
public:
    void f(){cout << "Base::f()" << endl;}
    virtual void vf() {cout << "Base::vf()" << endl;}
};

class Derived:public Base{
public:
    void f(){ cout << "Derived::f()" << endl;}
    void vf() override { cout << "Derived::vf()" << endl;}
};

int main(){

    Base base;
    Derived derived;
    Base* pBase;

    pBase = &base;
    pBase->f();
    pBase->vf();

    pBase = &derived;
    pBase->f();
    pBase->vf();

    return 0;
}
```

```
Base::f()
Base::vf()
Base::f()
Derived::vf()
Program ended with exit code: 0
```

Base 클래스의 주소를 담는 포인터 변수 `pBase` 를 선언하고, 이 주소에 `base` 객체의 주소를 담고서, 두 멤버함수를 호출하니 당연히 Base 클래스의 함수들이 호출되는 것을 알 수 있다.

그런데, `derived` 객체의 주소를 담으면, (부모 클래스에 자식 클래스를 넣을 수는 있다고 앞글에서 설명했다.) 이 때, 멤버함수는 **Base의 f(), Derived 의 vf()** 가 호출되었음을 알 수 있다.

즉, 해당 객체의 멤버함수를 **기본적으로는 Base 에서 가져온다.** **하지만 Virtual 선언이 되어 있다면, 어떤 객체인지 파악후 그 객체의 멤버함수를 가져온다** 이런 작업은, 프로그램이 실행되면서 묶일 수 밖에 없으므로, **_동적 바인딩_** 이라 불린다.

## 동적 바인딩의 의미

우리는 이 기술을 사용해서, 서로 다른 자료형들을 하나의 벡터안에 넣어서 관리할 수 있다.

```c++
#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Base{
public:
    void f(){cout << "Base::f()" << endl;}
    virtual void vf() {cout << "Base::vf()" << endl;}
};

class Derived:public Base{
public:
    void f(){ cout << "Derived::f()" << endl;}
    void vf() override { cout << "Derived::vf()" << endl;}
};

int main(){

    Base* pBase;
    vector<Base*> v{ new Base, new Derived, new Base};
    pBase = new Derived;
    v.push_back(pBase);
    pBase = new Base;
    v.push_back(pBase);

    for (auto elem: v)
        elem->vf();

    return 0;
}

```

```
Base::vf()
Derived::vf()
Base::vf()
Derived::vf()
Base::vf()
Program ended with exit code: 0
```

`Base` 클래스의 주소를 담는 자료형을 기반으로 벡터를 만들고, 그 안에, 내가 원하는 클래스를 담으면, `virtual` `override` 구조에 따라서 자동으로 멤버함수가 결정된다!

# Pure virtual function (순수 가상 함수)

`virtual` 을 선언할 때, 특별히 기본 Base 클래스에서는 기능을 정의하지 않고 파생 클래스에서 이 함수를 정의해서 사용할 때가 있는데 이때 선언하는 것이 **순수 가상함수** 이다.

```c++
virtual print() = 0;
```

순수 가상함수를 선언할 때는, base 클래스에서 이 함수의 작동이 없다는 것을 명시하기 위해서 뒤에 `=0` 을 추가로 달아준다. 이 표시가 있을 경우 우리는 파생 클래스로부터 이 함수를 필수적으로 정의해야한다. 또한 Base 클래스에서 위와 같이 선언했을 경우 **main 함수에서 우리는 저 함수를 사용할 수 없다.**

## abstract Class(추상 클래스)

내가 파생클래스들로 무언가를 만들어 사용하고 싶을 때, 그 윗단계에서 이 함수들에 대한 개략적인 것들을 적어둔 상위 집합의 클래스를 만들 수 있을 것이다.

이 때, 순수 가상함수들로 구성된 하나의 클래스를 **추상클래스** 라 부른다. 이렇게 관리할 경우 우리는 어떤 클래스들의 공통된 특징을 묶어서 관리할 수 있으므로 용이하다.

# Header File

## 왜 사용하는가?

C++ 코드를 작성하다가 보면, Class 내의 멤버변수, 멤버함수, 또 내가 만들어서 사용하는 사용자 정의 함수, main 함수등 결국 어떤 프로그램을 동작하고 싶은 건지 전체적 구조를 알기 어렵다는 점이 있다. 따라서 우리는 class를 정의하는 것은 hpp 확장자에, 그리고 그 클래스에 해당되는 멤버함수들은 cpp 확장자에, 프로그램이 동작하는 main 에는 지저분한 것을 없애고 큰틀만 두는 것이다. 이 때, 내가 만들어 놓은 hpp 를 **#include** 하고 사용하는 것이다.

여태껏 `<>` 안에 적었던 것은, 기본적으로 c++에서 제공하는 라이브러리 이며, 이제부터 내가 만들어 사용하는 녀석들은 `""` 안에 적어서 사용한다.

### main()

```c++
//
//  main.cpp
//  last_example
//
//  Created by 최완식 on 13/05/2019.
//  Copyright © 2019 최완식. All rights reserved.
//

#include <iostream>
#include <vector>
#include <string>
#include "CText.hpp"
#include "CFancyText.hpp"
#include "CFixedText.hpp"
using namespace std;

int main() {
    vector<Text*> v{ new Text("Plain"),
        new FancyText("Fancy1", "<", ">", "-"),
        new FixedText };

    Text* pText;
    pText = new FancyText("Fancy2", "[", "]", "*");
    v.push_back(pText);
    pText = new Text("Plain2");
    v.push_back(pText);

    for (auto elem : v)
        elem->append("A");

    for (unsigned i = 0; i < v.size(); i++)
        cout << i << " : " << v.at(i)->get() << endl;


    return 0;
}

```

우리는, v라는 벡터안에 Text 객체, FanctText 객체, FixedText 객체를 넣을 것이다. FancyText 클래스는 Text를 상속받아 추가적인 텍스트를 추가한다. FixedText 클래스는 Text를 상속받지만 일관된 출력을 한다. 마지막으로 모든 객체는 Text 클래스로 부터 append 라는 멤버함수를 상속받으니, for문을 돌면서 A라는 문자를 다 추가한다.

### CText.hpp

```c++
#pragma once
#include <string>
using namespace std;

// Text.h
class Text {
private:
    string text;
public:
    Text(string _t);
    virtual string get();
    virtual void append(string _extra);
};

```

`pragma once`는 한 번 `#include` 된 파일은 다시 열지 않도록 하는 명령어 이다.

### CText.cpp

```c++
#include "CText.hpp"

// Text.cpp
Text::Text(string _t) : text(_t) {}
string Text::get() { return text; }
void Text::append(string _extra) { text += _extra; }

```

같은 이름을 가진 헤더파일을 cpp에서 include 하고 멤버함수를 작성한다.

### CFancyText.hpp

```c++
#pragma once
#include <string>
#include "CText.hpp"
using namespace std;

class FancyText : public Text {
private:

    string left_brac;
    string right_brac;
    string connector;
public:

    FancyText(string _t, string _lb, string _rb, string _con);
    string get() override;
    void append(string _extra) override;
};
```

### CFancyText.cpp

```c++
#include "CFancyText.hpp"

FancyText::FancyText(string _t, string _lb, string _rb, string _con) :
Text::Text(_t), left_brac(_lb), right_brac(_rb), connector(_con) {}


string FancyText::get() { return left_brac + Text::get() + right_brac; }


void FancyText::append(string _extra) {
    Text::append(connector + _extra);
}

```

### CFixedText.hpp

```c++
#include "CText.hpp"
using namespace std;

class FixedText : public Text {
public:
    FixedText();
    void append(string _extra) override;
};
```

### CFixedText.cpp

```c++
#include "CFixedText.hpp"


FixedText::FixedText() : Text::Text("FIXED") {}
void FixedText::append(string _extra) {
    //NOOP
}
```

### 다시 main()

```c++
#include <iostream>
#include <vector>
#include <string>
#include "CText.hpp"
#include "CFancyText.hpp"
#include "CFixedText.hpp"
using namespace std;

int main() {
    vector<Text*> v{ new Text("Plain"),
        new FancyText("Fancy1", "<", ">", "-"),
        new FixedText };

    Text* pText;
    pText = new FancyText("Fancy2", "[", "]", "*");
    v.push_back(pText);
    pText = new Text("Plain2");
    v.push_back(pText);

    for (auto elem : v)
        elem->append("A");

    for (unsigned i = 0; i < v.size(); i++)
        cout << i << " : " << v.at(i)->get() << endl;


    return 0;
}

```

### Output

```
0 : PlainA
1 : <Fancy1-A>
2 : FIXED
3 : [Fancy2*A]
4 : Plain2A
Program ended with exit code: 0
```

# Binding 의 시각화

`vtable` 이란 멤버함수를 동적으로 할당하는 변수이다. 어떤 객체를 넣느냐에 따라 다른 멤버함수가 할당되는 것을 볼 수 있다.

<img width="800" alt="스크린샷 2019-05-13 오후 1 09 06" src="https://user-images.githubusercontent.com/37871541/57595489-4b3c0880-7580-11e9-84f4-dba5cfb5cb5c.png">{: .center width="80%"}_Binding의 시각화_
