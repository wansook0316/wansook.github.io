---
layout: post
title: "Git의 구조"
category: "DV/iOS"
comments: true
tags: [commit, git]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
summary: "Git은 어떤 구조로 이루어져 있는가?"
---

깃을 사용하기만 해봤지, 실제 구현해보려하니, 어떤식으로 해야할지 감이 잘 잡히지 않았다. 이번에는 구조에 대해서 알아보려 한다.

# .git의 디렉토리 구조

```
$ ls -F1
config
description
HEAD
hooks/
info/
objects/
refs/
```

* description
  * gitweb 프로그램에서만 사용
* config 
  * 해당 프로젝트에만 적용되는 설정 옵션
* info
  * .gitignore 처럼 무시할 파일의 패턴을 적어두는 곳
  * 하지만 .gitignore의 경우는 git으로 관리되는데 이녀석은 아니다.
* hooks
  * 클라이언트 훅이나 서버 훅이 위치
  * 무슨 말인지 모르겠다. git hooks에서 설명한다고 한다.
* HEAD
  * 현재 체크아웃한 브랜티를 가리킨다.
* index
  * Staging Area의 정보를 저장한다.
* objects
  * 모든 컨텐츠를 저장하는 데이터 베이스
* refs 
  * 커밋 객체의 포인터(Branch, tag, remote)를 저장한다.


아래의 4개의 항목이 Git의 핵심이다.

# Git 개체

* Key-value 시스템
* 어떤 형식의 데이터라도 집어 넣을 수 있고, key로 데이터를 다시 가져올 수 있다.
  * `git hash-object`
  * 이 명령에 데이터를 주면 `.git/objects` 디렉토리에 저장하고 데이터에 접근할 수 있는 key를 알려준다. 그리고 이 key는 유일하다.

```
$ git init test
Initialized empty Git repository in /tmp/test/.git/
$ cd test
$ find .git/objects
.git/objects
.git/objects/info
.git/objects/pack
$ find .git/objects -type f
```

* 처음 초기화하면 파일은 아무것도 없다.
* 초기화하면 `objects` 디렉토리를 만들고 아래에 pack, info 디렉토리를 만든다.


```
echo 'test content' | git hash-object -w --stdin
d670460b4b4aece5915caf5c68d12f560a9fe3e4

```
* git hash-object 명령은 주어지는 데이터를 저장하고 이 데이터에 접근하기 위한 key를 반환한다. 
* -w 옵션을 줘야 실제로 저장한다. 
* -w 가 없으면 저장하지 않고 key만 보여준다. 
* 그리고 --stdin 옵션을 주면 표준입력으로 입력되는 데이터를 읽는다. 
  * 이 옵션이 없으면 파일 경로를 알려줘야 한다.

더 많은 내용을 적으려 했으나, 이 튜토리얼 문서가 너무 잘되어 있어 생략한다. 아래에는 이해한 내용을 정리하도록 한다.

## Blob
* 파일 전체에 대한 key value 구조를 채택했다.
* 헤더와 문서(데이터) 전체에 대한 SHA-1 해시값을 받고(40자) 2자는 해당 디렉토리 이름, 나머지를 파일이름에 사용한다.
* 수정하고 다시 git 데이터 베이스에 저장하면 두가지 버전으로 저장이된다. (데이터가 달라졌기 때문에 다른 해시가 튀어나옴)
* 이렇게 저장이 된 상태이기 때문에, 저장을 하려한 파일을 지우더라도, 불러올 수 있다.
* 이 때는 `cat-file` 이라는 명령어를 사용한다.

```
git cat-file -p 83baae61804e65cc73a7201a7252750c76066a30 > test.txt
cat test.txt

version 1
```
* `-p` 명령을 주어야 출력된다.
* `>`은 리눅스 스트림의 방향을 조정하는 명령어이다.
* `redirection` 이라 부른다.
* 그 다음 동작에 대해 명령의 결과를 파일로 저장하라는 명령어이다.
* `>>` 명령어도 있는데, 이건 뒤에 나오는 파일의 뒤에 왼쪽 내용을 추가하라는 의미이다.
* `<` 은 파일의 데이터를 명령에 입력하라는 명령어이다.

```bash
cat fname1 fname2 > fname3
# fname1,fname2 를 출력하고 fname3 이라는 파일에 저장합니다.
cat fname4 >> fname3
# fname3 에 fname4 의 내용을 추가합니다.
cat < fname1
# fname1 의 내용을 출력합니다.
```

* 그런데 이렇게 SHA-1 키를 외워서 사용하는 것은 지옥이다.
* 해당 파일의 이름은 저장도 되지 않은 상태라 어떻게 돌려야하는지도 모른다.
* 일단 이러한 종류의 개체를 `blob` 이라 부른다.

## Tree

* 파일 이름을 저장한다.
* Staging Area(Index)의 상태대로 Tree 개체를 만들고 기록
* 해당 튜토리얼에서는 데이터베이스에 등록된 두개의 blob 객체를 Staging area 에 추가하는 방법을 알려준다.
* 또한 이전에 바꿔둔 파일에 대해서 이를 해당 트리의 하위 트리로 등록하는 방법 또한 알려준다.
* 여기서 배울 수 있는 부분은 이와 같다.
  * blob은 파일 자체를 key value로 구성한 파일이다.
  * tree는 해당 blob 파일을 트리구조로 이름과 함께 관리한다.
  * tree안에는 해당 blob 파일을 관리할 수 있다.
  * 하위 트리역시 넣을 수 있다.
  * 이것 자체를 스냅샷이라 볼 수 있을 것이다.
    * 내가 원하는 것들에 대해서 상태를 저장한 상태이니까.
  * 이렇게 Tree에 등록하는 것 자체가 Staging area에 올리는 것이라 할 수 있겠다.
  * 트리를 만들면 이 역시 고유의 SHA-1 이름을 갖는다.


![image](https://user-images.githubusercontent.com/37871541/128621259-3c21348b-fcb6-48b8-8512-3502470fbf90.png){: .center-small}_Tree의 구조_



# Commit

* 위에서 Staging Area에 올리는, 즉 Tree에 내가 원하는 blob 객체를 추가한 상태지만, 이 Tree 자체에 대한 정보가 없다.
* 즉, 내가 만든 스냅샷 자체에 대해서 누가, 언제, 왜 저장했느냐에 대한 정보가 없다.
* 또한 해당 스냅샷을 불러오기 위해서는 해당 Tree의 SHA-1 값을 기억하고 있어야 한다.
* 이러한 정보들을 관리하는 것이 Commit 객체이다.

```
$ echo 'first commit' | git commit-tree d8329f
fdf4fc3344e67ab068f836878b6c4951e3b15f3d
```

* 이런식으로 내가 원하는 트리에 대해 Commit을 할 수 있다.
* 해당 커밋에 대해 읽어보면,

```
$ git cat-file -p fdf4fc3
tree d8329fc1cc938780ffdd9f94e0d364e0ea74f579
author Scott Chacon <schacon@gmail.com> 1243040974 -0700
committer Scott Chacon <schacon@gmail.com> 1243040974 -0700

first commit
```

* 익숙한 내용이보인다.
* 기존에 등록된 author, committer에 대한 정보가 들어가고 (user.name, user.email)
* 시간, 메시지가 들어간다.
* 가장 최근에 만든 커밋 밑에 두개의 커밋을 연달아서 달아보자. 이 때 가장 위의 커밋의 Tree key밑에 달도록 한다.

```
$ echo 'second commit' | git commit-tree 0155eb -p fdf4fc3
cac0cab538b970a37ea1e769cbbde608743bc96d
$ echo 'third commit'  | git commit-tree 3c4e9c -p cac0cab
1a410efbd13591db07496601ebc7a059dd55cfe9
```

```
$ git log --stat 1a410e
commit 1a410efbd13591db07496601ebc7a059dd55cfe9
Author: Scott Chacon <schacon@gmail.com>
Date:   Fri May 22 18:15:24 2009 -0700

    third commit

 bak/test.txt | 1 +
 1 file changed, 1 insertion(+)

commit cac0cab538b970a37ea1e769cbbde608743bc96d
Author: Scott Chacon <schacon@gmail.com>
Date:   Fri May 22 18:14:29 2009 -0700

    second commit

 new.txt  | 1 +
 test.txt | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

commit fdf4fc3344e67ab068f836878b6c4951e3b15f3d
Author: Scott Chacon <schacon@gmail.com>
Date:   Fri May 22 18:09:34 2009 -0700

    first commit

 test.txt | 1 +
 1 file changed, 1 insertion(+)
```

* 그러면 이렇게 익숙한 구조가 나온다.
* 가장 첫번째에 만든 커밋에 연달아 커밋이 달려서 변경 사항이 저장된다.
* 이렇게 만들어진 객체는 모두 `./git/objects` 디렉토리에 저장된다.

```
$ find .git/objects -type f
.git/objects/01/55eb4229851634a0f03eb265b69f5a2d56f341 # tree 2
.git/objects/1a/410efbd13591db07496601ebc7a059dd55cfe9 # commit 3
.git/objects/1f/7a7a472abf3dd9643fd615f6da379c4acb3e3a # test.txt v2
.git/objects/3c/4e9cd789d88d8d89c1073707c3585e41b0e614 # tree 3
.git/objects/83/baae61804e65cc73a7201a7252750c76066a30 # test.txt v1
.git/objects/ca/c0cab538b970a37ea1e769cbbde608743bc96d # commit 2
.git/objects/d6/70460b4b4aece5915caf5c68d12f560a9fe3e4 # 'test content'
.git/objects/d8/329fc1cc938780ffdd9f94e0d364e0ea74f579 # tree 1
.git/objects/fa/49b077972391ad58037050f2a75f74e3671e92 # new.txt
.git/objects/fd/f4fc3344e67ab068f836878b6c4951e3b15f3d # commit 1
```

* 내부 포인터를 따라가보면 이러한 그림이 그려진다.

![image](https://user-images.githubusercontent.com/37871541/128621515-e8b6248a-563f-4792-ac56-8169c489e3b4.png){: .center-small}_저장소 내의 모든 개체_

* 정리
  * blob은 만들어진 object 파일이 모두 들어가 있다.
  * tree는 생성된 파일을 등록한다. 하위 트리도 가질 수 있으며 이는 아마 directory 와 같은 구조를 저장하기 위함으로 보인다.
  * commit안에는 해당 tree(스냅샷, 스테이징 에어리아)가 들어가 있다.


# 저장소

* 아까 위에서 blob을 만들 떄, 헤더도 들어간다고 했다.
* 해당 튜토리얼에서는 ruby를 사용해서 헤더가 어떤식으로 들어가는지를 보여주고, 이를 SHA-1 해시한 결과와 실제 git has-object 결과와 같은지를 보여준다.
* 결론
  * 헤더가 어떠한 문서이든간에 추가되게 된다.
    * `blob {content.length}\0` + data
    * 와 같은 식으로 추가된다.


# Refs

* 지금까지 잘 이해했다면 문제가 하나있다.
* 특정 커밋에 접근하기 위해서는 SHA-1 값을 모두기억해야 한다는 점이다.
* 이러한 점을 쉽게하기 위해서 refs를 등록해서 쉽게 해당 포인터를 알아볼 수 있다.
* 이러한 것을 관리하는 곳이 `.gits/refs` 안에 디렉토리를 만들고 파일을 만들어 관리할 수 있다.

```
$ echo 1a410efbd13591db07496601ebc7a059dd55cfe9 > .git/refs/heads/master
```

* 이렇게 직접적으로 추가할 수도 있지만, 명령어가 존재한다.

```
$ git update-ref refs/heads/master 1a410efbd13591db07496601ebc7a059dd55cfe9
```

* <mark style='background-color: #fff5b1'> 이것이 바로 브랜치이다! </mark> 
* 단순히 어떤 특정 커밋의 포인터를 가리키는 ref에 불과한 것이다.
* 두번쨰 커밋을 가리키는 브랜치를 만들어보면,

```
$ git update-ref refs/heads/test cac0ca
```

* 이것에 불과하다.. 그리고 해당 브랜치에서 로그를 찍으면 당연히 가리키고 있는 commit이 가지고 있는 tree 안의 내용만을 보여준다.

```
$ git log --pretty=oneline test
cac0cab538b970a37ea1e769cbbde608743bc96d second commit
fdf4fc3344e67ab068f836878b6c4951e3b15f3d first commit
```

![image](https://user-images.githubusercontent.com/37871541/128621791-c02215c4-72c9-42d4-a8e6-bf810af87e9b.png){: .center-small}_브랜치가 추가된 Git database_

# HEAD

* 그러면 Head는 어떻게 가장 최근의 commit을 아는가?
* 이녀석은 master 브랜치 자체 ref 하고 있다고 생각하면 된다.

```
$ cat .git/HEAD
ref: refs/heads/master
```

* 이렇게 생겼다.
* 즉, 특정 SHA-1값(커밋의)을 가지고 잇는 것이 아니고,  ref 자체를 가지고 있다.
* 만약 체크아웃을 한다면?

```
$ cat .git/HEAD
ref: refs/heads/test
```

* 이렇게 내부 파일을 바꾼다.
* 파일 자체를 손으로 편집해도 되지만 git에서는 명령어를 제공한다.

```bash
# 파일 읽기
$ git symbolic-ref HEAD
refs/heads/master
# 파일 변경하기
$ git symbolic-ref HEAD refs/heads/test
$ cat .git/HEAD
ref: refs/heads/test
```

# Tag

* 릴리즈할 떄 보통 사용함
* 해당 Commit에 대해 말그대로 태그를 달아두는 것
* Commit과 비슷하나, Tree 개체를 가리키지 않고, 커밋 개체를 가리킨다.
* 그리고 branch는 커밋캐체를 옮길 수 있지만, 태그책체는 그것은 할 수 없다.
* 태그를 달은 사람, 시간, 메시지등은 동일하다.


# References

* [Git의-내부-Git-개체](https://git-scm.com/book/ko/v2/Git%EC%9D%98-%EB%82%B4%EB%B6%80-Git-%EA%B0%9C%EC%B2%B4)