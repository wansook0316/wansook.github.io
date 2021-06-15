---
layout: post
title: "16: Inherence (상속)"
category: "DV/C++"
comments: true
tags: [c++, "OOP"]
feature-img: "assets/img/2.jpg"
feature-title:
use_math: true
series: "Object Oriented Programming"
summary: "상속이란?"
---

# 전체적인 구조

<img width="800" alt="스크린샷 2019-05-04 오후 1 44 24" src="https://user-images.githubusercontent.com/37871541/57174021-bdbb3300-6e72-11e9-9ce1-221f1ef3c442.png">{: .center width="50%"}_한번에 이해하기_

# 상속이 필요한 이유

상속은 매우 유용하다. 이전에 클래스를 다뤘던 글을 다시 기억해보자. [13: class, object](https://wansook0316.github.io/dv/c++/2020/09/28/OOP-13-class-object.html)

우리가 클래스를 사용하는 이유는, 쉽게 말해, 어떤 물체를 정의해서 사용하는 것이 더 합리적이라는 판단이 들어서이다. 함수만 가지고서 무언가를 만들기 보다는, 내가 물건을 정의하고 그 물건들을 실제로 만든뒤, 물건들로 다른 활동을 하는 것이 보다 쉽기 때문이다.

이전에 사용했던 사진을 다시 사용해보면,

<img width="800" alt="스크린샷 2019-05-04 오후 1 48 05" src="https://user-images.githubusercontent.com/37871541/57174047-41751f80-6e73-11e9-8a05-8f562b7a8042.png">{: .center width="50%"}_class, object, instance_

간단하게 이렇게 정의할 수 있다. 물체를 정의하기 위해 만들어진 것이 **클래스**, 그 클래스를 기반으로 만들어질 대상이 **객체**, 실제로 만들어져 구체화 된 물체를 **인스턴스**라 부른다.

그럼, 상속의 개념은 왜 필요할까? 위의 클래스 예시에서 리모컨 설계도는 굉장히 다양할 수 있다. TV 리모컨, 차 리모컨, 에어컨 리모컨,, 이렇게 다양한 리모컨이 있지만, 이녀석을 세상에 존재하는 하나의 물건(인스턴스)로 구현하기 위해서는, 각자에 맞는 설계도(Class)가 따로 필요하다. 하지만 이녀석들이 가지는 근본적인 특성은 모두 동일하다.

이 설계도(Class)를 만들 때 있어서 보다 큰 집합 개념을 도입하면 어떨까? 더 큰 클래스에서 가지는 특성을 변형해서 다른 클래스를 만들면 어떨까? 이것이 바로 **상속** 이다.

<img width="800" alt="스크린샷 2019-05-04 오후 2 00 41" src="https://user-images.githubusercontent.com/37871541/57174165-04aa2800-6e75-11e9-9dcb-5b5601d8d5f6.png">{: .center width="50%"}_상속의 필요성_

이렇게 부모 클래스로 부터 파생된 다른 녀석들을 만들어 가져다 쓸 수 있다. 따라서 부모클래스는 자식클래스의 내용을 반드시 가질 수 밖에 없다. 그렇기 때문에 부모 클래스가 (A) 이고, 부모클래스로 부터 만들어진 파생 클래스가 (A') 라 했을 때, 각각의 클래스로 부터 만들어진 객체가 (a, a')이라 하면, 할당이 가능한 방법은 하나뿐이다.

```c++
a = a';		// 가능
a' = a;		// 불가능
```

이렇게 부모는 자식의 내용을 일부 가지고 있기 때문에 없는 변수나, 함수에 관해서는 무시하고 있는 값만 할당 받으면 되지만, **자식 객체에 부모 객체를 할당 할 수 없다.** 자식 객체가 가지는 변수는 부모객체가 가지고 있지 않기 때문에 어떤 값을 할당 받아야하는지 모호해지기 때문이다.

# Base 와 Derived 간 상속관계

<img width="894" alt="스크린샷 2019-05-02 오후 12 07 22" src="https://user-images.githubusercontent.com/37871541/57054959-db519680-6cd2-11e9-92fa-2d3900aa1d38.png">{: .center width="50%"}_상속 Type과 속성_

## Summary

- **Base : Private** -> 사용 불가
- **Base : Protected** -> Private
- **Base : Public** -> 상속 타입에 따라 변화!

# Example 1

```c++

#include <iostream>

using namespace std;

class Base {
public:
    void print_base() { cout << "Base" << endl; }
};

class Derived : private Base{ // Base를 Private으로 받으니,
    						  // 이 클래스 내에서는 모두 Private으로 받는다.
// 따라서 지금은 적혀 있지 않지만, 이 클래스의 private는 Base 클래스가
// 가지는 public내의 변수와 함수를 갖는다.

public:
    void print_derived() {
        Base::print_base();	// 그렇기 때문에 여기서 Base 클래스의 함수를 사용할 수 있다.
        					// private이니까!
        cout << "Derived" << endl; }
};


int main(){

    Base base;
    Derived derived;

    base.print_base();
    //derived.print_base();  이 부분은 에러가 뜬다.
    					 //	Derived 클래스에서는 print_base 함수가 Private 이다.
    derived.print_derived();

    return 0;
}




```

```
Output
Base
Base
Derived
Program ended with exit code: 0
```

# Initialize List의 중요성

지금까지 위에서 클래스를 상속하는데 있어, 기존 클래스에서 정의된 속성과, 파생 클래스에서 어떤 방식으로 상속을 받는지에 따라 사용할 수 있는 범위가 제한됨을 배웠다.

그런데 보통 우리는 클래스를 작성할 때, **Private에 이 클래스가 가지는 변수들을 정의**하여 사용한다. 그렇기 때문에 내가 파생클래스를 작성 할때, 상속 속성을 **Public** 으로 준다고 하더라도, Private에 작성된 녀석은 사용할 수가 없다. 따라서 내가 만든 파생 변수가 기존의 클래스를 따와서 **같은 변수들을 넣어줘야 함에도 그 변수에 접근할 수가 없다** 는 문제가 발생한다.

이 때, Initialize List가 중요한 이유가 나온다. 예제를 통해 알아보자.

## Example

```c++
#include <iostream>
#include <string>

using namespace std;

// 부모 클래스의 생성자를 Public에 정의했다.
class Text{
private:
    string text;
public:
    Text(string _t) : text(_t) {}
};

// 파생 클래스에서는 부모 클래스를 받아, 추가적인 기능을 구현하도록 한다.
// 이 때 부모클래스의 Private는 파생클래스에서 직접적으로 사용할 수 없다.
class FancyText: public Text{
private:
    // string text; 이 변수는 파생클래스에서 직접적으로 사용할 수는 없다.
    // 하지만 상속 받았기 때문에 이 변수는 파생 클래스에서도 중요한 역할을 할 것이다.
    // 그렇다면 파생 클래스를 선언할 때, 이 변수를 어떻게 받을 수 있을까?
    string left_brac;
    string right_brac;
    string connector;

public:
    // 정답은 파생 클래스에서 생성자를 호출할 때, Initialize list를 사용하면 되는데,
    // 사용자로 부터 초기값을 받을때, 그 값을 initialize list의 인자로 넘겨준다.
    // 위의 부모 클래스의 생성자를 보게되면, Public으로 선언되었기 때문에,
    // 파생 클래스에서 이 생성자를 가져다가 사용할 수 있다!!
    FancyText(string _t, string _lb, string _rb, string _con):
    Text::Text(_t), left_brac(_lb), right_brac(_rb), connector(_con){
    }
    // Text::Text(_t) 이 부분이 부모클래스의 생성자를 호출한 부분이다.
    // 따라서 우리는 private로 선언되어 있는 부모클래스의 속성 부분을
    // 간접적으로 생성자를 호출함으로써 초기화에 성공했다.
};


class FixedText : public Text{
public:
    FixedText() : Text::Text("FIXED"){}
    // 생성자를 호출할 수 있게 해준다는 것이 initialize list의 엄청난 장점!!!!
};
```

# function overloading

이름만 같은 함수를 의미한다. 입력 파라미터의 자료형, 입력 파라미터의 갯수, 출력파라미터의 자료형 등, 아무 상관이 없다. 하지만 함수 이름을 동일하게 작성했기 때문에 아마도 본질적으로 수행하는 내용은 동일 할 것이다. 따라서, 함수 오버로딩은, **하는 행동, 본질(A)이 동일한 녀석** 이라고 생각하면 된다. 결국 같은 이름의 다른 함수들이 **쌓이** 고 있기 때문에 우리는 **function overloading** 이라 한다.

```c++
int    sum(int x, int y),
double sum(double x, double y)
float  sum(float x, float y, float z)
```

# function overriding

함수 오버라이딩은 상속의 특수한 경우에 해당되는데, base 클래스의 함수로 부터 상속받아 구체적이거나, 혹은 이 클래스에 맞는 방식으로 함수를 재정의 할 때 사용한다.

즉, **같은 이름, 또 같은 입력파라미터**를 받으나, 함수내의 작동에 있어서 함수 오버로딩 처럼 (A)의 본질을 따르기 보다는, **A' 혹은 B** 와 같이 변경이 있을 수 있다. 상속을 받아 이녀석의 내용을 변경하고 있으므로, 원래 클래스의 함수에 내가 원하는 내용을 **추가 혹은 올라타** 고 있다. 따라서 **function overloading** 이다.

# Virtual, override

우리는 함수 오버로딩을 할때, 부모 클래스로 부터 자식 클래스로 갈때, 변경될 수 있다는 것을 명시해주기 위해 **_Virtual_** 이라는 단어를 명시해주고, 또 자식클래스에서는 부모클래스로 부터 받았다는 것을 알려주기 위해 **_override_** 라는 단어를 사용한다.

사실 프로그램을 구동하는데는 문제가 없지만,

1. 유지보수
2. Polymorphism (다형성)

을 위해 필수적이니 명시적으로 작성해주는 것을 습관들이자.

# 소스코드 총 정리

```c++
#include <iostream>
#include <string>

using namespace std;

class Text{
private:
    string text;
public:
    Text(string _t) : text(_t) {}

    // 이 함수는 가상이며, 파생클래스에서 구체화 될것을 명시한다.
    virtual string get(){ return text;}
    virtual void append(string _extra) {text += _extra; }
};

class FancyText: public Text{
private:
    string left_brac;
    string right_brac;
    string connector;
public:
    FancyText(string _t, string _lb, string _rb, string _con):
    Text::Text(_t), left_brac(_lb), right_brac(_rb), connector(_con){
    }

    // 부모 클래스로 부터 override 된 함수임을 명시해준다.
    string get() override { return left_brac + Text::get() + right_brac; }
    void append(string _extra) override{
            Text::append(connector + _extra);
        // 이 함수내용을 작성하는데 있어, text = text + connector + _extra;
        // 이렇게 쓸 수 없다. 부모클래스의 text는 private로 선언되어 있기 때문이다.
        // 그렇기 때문에 우리는 부모클래스에 정의된 public 특성의 함수로 접근해서 작성해야 한다.
        }
};

class FixedText : public Text{

public:
    FixedText() : Text::Text("FIXED"){}
    void append(string _extra) override{
        // no operation
    }
};



int main(){

    Text t1("Plain");
    t1.append("A");
    cout << t1.get() << endl;


    FancyText t2("Fancy", "<<", ">>", "***");
    t2.append("A");
    cout << t2.get() << endl;

    FixedText t3;
    t3.append("A");
    cout << t3.get() << endl;

//    t1 = t2; // 자식 클래스 내용은 부모에 넣을 수 잇음
//    t2 = t1;    // 반대는 안댐
//    return 0;
//}
```

```
Output
PlainA
<<Fancy***A>>
FIXED
Program ended with exit code: 0
```
