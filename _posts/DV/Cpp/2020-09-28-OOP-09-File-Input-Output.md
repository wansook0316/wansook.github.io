---
layout: post
title: "09: File Input & Output (파일입출력)"
category: "DV/C++"
comments: true
tags: [c++, "OOP"]
feature-img: "assets/img/2.jpg"
feature-title:
use_math: true
series: "Object Oriented Programming"
summary: "파일 입출력을 예제로 알아보자."
---

# fstream

## Reading from file

```c++
#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main(){
    string line;
    ifstream myfile("input.txt");

    if (myfile.is_open()){
        while(getline (myfile, line)){	// string의 함수 getline
   										// myfile 에서 1줄씩 읽어들여 line 스트링 변수에넣는다.
            							// 없으면 0을 반환한다.
            							// 있으면 1을 반환한다.
            cout << line << endl;
        }
        myfile.close();
    }
    else {
        cout << "unable to open file";
    }

    return 0;
}
```

## Writing to file

```c++
#include <iostream>
#include <fstream>

int main(){
    ofstream myfile("output.txt");
    myfile << "writing this to a file.\n";
    myfile.close();

    return 0;
}
```

## Formatting Data

```c++
#include <fstream>
#include <iostream>

using namespace std;

int main(){
    ofstream fout("output.txt");
    int a = 123;
    double b = 12.12345678;

    fout.width(15);	// 값을 출력하는데 있어 기본 칸 크기
    fout << a << endl;
    fout.width(15);
    fout.precision(10);
    fout << b << endl;

    fout.close();
    return 0;
}
```

```
            123
12.12345678
```

## cin.unsetf()

```c++
cin.unsetf(ios::skipws);	// 파일을 읽을 때 공백 문자가 나오면 버린다.
```
