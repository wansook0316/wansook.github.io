---
layout: post
title: "Git Tutorial"
category: "DV/Concept"
comments: true
tags: [Concept, git, github]
feature-img: "assets/img/78.jpg"
feature-title: ""
use_math: true
series: "Git & Github"
summary: "정리하는 겸 해보기!"
---



![image](https://user-images.githubusercontent.com/37871541/121855986-ef2fa980-cd2e-11eb-893b-3210348971f3.png){. :center}_github workflow_

![image](https://user-images.githubusercontent.com/37871541/121856830-e8556680-cd2f-11eb-9aa8-d423890f6522.png){. :center}_github summary_



1. clone : 기존 레포 복사떠서 가져오기
2. pull : 수정사항 있으면 fetch+merge 수행
3. push : 원격 저장소에 올리는 것
4. add : staging area에 올리기
5. commit : 로컬 저장소에 반영 (해시값으로 되어 있음)
6. reset : 뒤에 hash 값주면 돌아감 (hard, soft, mixed)
7. rebase : 브랜치 따서 쭉 작업하다보면 가지 길이 달라지고 난리가 남. 이런 경우 정리하고 싶다! 할때 사용하는 방법
8. branch : 뭐 개발할거면 항상 따서 하기
9. merge : master 기준으로 merge 한다.
10. conflict : 소스코드 선정하고 다시 commit후 반영
11. log : 현재까지의 상황 파악 가능
12. remote : 원격 저장소에 관한 것
    1.  원격 저장소는 여러개가될 수 있음
    2.  그리고 별명을 달아둘 수 있음
    3.  `git remote show [별명] ` 이렇게 사용하면 내가 지금 선정한 원격저장소에 관한 내용알 수 있음
    4.  즉, 하나의 로컬 저장소에서도 여러개의 원격 저장소를 설정할 수 있음
    5.  `git remote add [별명] gitlink`
    6.  `git remote rename [원래별명] [ 변경별명]```python



# Pull request!!!

1. organization 만들기
2. 팀원 초대
3. 레포 만들기
4. 해당 레포 fork
5. clone해서 가져오기
6. repository setting에서 remote origin 별명을 upstream으로 변경
7. clone한 repo 주소 입력
8. branch 따기
9.  내 레포에 commit
10. 원본 repo에 반영됨!! 야호!


# 다시 원론적으로 접근

* 시간 여행, 평행 우주를 만든다고 생각


```bash
git init # 해당 폴더에 git을 생성
git config --global user.name wansook0316 # 해당 git을 사용하는 이름 설정
git config --global user.email wansook0316@gmail.com # 이메일 설정

git status # 현재 상태 확인 가능
```

```bash
On branch master # 현재 마스터 브랜치에 있음

No commits yet

Untracked files
    # 아직 추적하고 있지 않은 파일들
    # 그냥 이 파일들이 생성되어 있다, 라는 사실만을 말해줌
```

```bash
git add -A # 현재 폴더에 있는 모든 것을 타임 캡슐에 넣겠다.
git status
```

```bash
On branch master # 현재 마스터 브랜치에 있음

No commits yet

Changes to be committed: # 묻을 파일들을 말하고 있음
    new file: cat
    new file: mouse

Untracked files
    # 아직 추적하고 있지 않은 파일들
    # 그냥 이 파일들이 생성되어 있다, 라는 사실만을 말해줌
```

```bash
git commit -m "First commit" # 해당 캡슐에 태그를 달아두는 것, 뒤에 -m은 message를 말함
```

```bash
git log # Commit log들을 보여준다.

commit 494fd65855808a1463ca9f16f6b1c5587042ca87 (wansook0316/feature) # 해시로 구성되어 있어서 해시값이 나와있다. 해당 commit ID로 돌아갈 수 있다.
Author: wansook <wansook0316@gmail.com> # 아까적은 user configuration
Date:   Mon Jul 19 15:20:22 2021 +0900

    [init] project files
```


# Reset(초기화) - 과거로 가기

* 과감한 방법 : 그냥 돌아가 `head`
  * 해당 시점 이후에 캡슐 묻은거는 다 파괴해

```bash
git reset "commit id"

HEAD is now at 339842 ADD Dog # 대가리, 즉, 니 머리가 가리키고 있는 곳이 339842라는 commit 타임 캡슐에 있고 그 떄 적어둔 태그가 ADD Dog이야.
```

# Revert(커밋 되돌리기) - 과거로 가기

* 소심한 방법
  * 이전 캡슐을 가져와서 최근 캡슐로 둔갑해서 묻어

```bash
git revert 234235

Revert "Add Modify DELETE"

This reverts commit 23623jnk2j45235b23k5n235.

# 커밋을 작성할 수 있는 vi editer 뜸
# 아래에 변화된 파일 목록 뜸

```

```bash
git log

# 돌아온 해당 시점 이후가 모두 사라진 것이 아니고,
# 새 캡슐을 묻어버림
# 반대되는 변화로 과거 시점의 상태를 만들어 버린것
```


# Branch - 평행 우주

```bash
git branch features # 현재 Head에서 새로운 브랜치 생성
git branch # 현재 브랜치를 확인할 수 있음
git checkout features # 해당 브랜치로 Head를 변경

git checkout -b features/audioFeature # 현재 브랜치에서 branch를 따면서 checkout까지 한번에

git branch -D features/audioFeature
```

브랜치 삭제는 소스트리에서 오른쪽 클릭 후 삭제. 이렇게 간단한걸 몰랐네.


# Merge - 해당 우주를 현재 우주로 가져오기


```bash
git merge feature/audioFeature feature # 새로운 피쳐 코드를 feature 브랜치에 병합

git log --graph --all --decorate # CLI에서 그래프 보여주기
```


# Conflict

머지할 때, 같은 소스파일을 수정할 경우 발생한다. 기능 리스트를 잘 나눠서 작업하는 것이 최선.



# Rebase - 예쁘게 만들어줘

![image](https://user-images.githubusercontent.com/37871541/126170083-ec780acc-dd1f-4485-b6bf-b0b97ac48f12.png){: .center-small}_마디는 없는데 계속 길어지는 그래프_

계속 이렇게 가면 그래프가 너무 지저분해진다. 이럴 때, 마디가 없는 부분을 있는 부분으로 감싸면서 1자로 만들어주는게 Rebase이다.

![image](https://user-images.githubusercontent.com/37871541/126170723-23ffeeb3-082f-4b26-9d5c-14a840277248.png){: .center-small}



# 협업 방법

```bash
git remote # 해당 폴더의 원격 저장소 확인

git remote add origin http~.git # origin이라는 별명으로 다음 github 저장소(URL)를 원격 저장소로 설정할거야 
git push -u origin master # 현재 branch의 내용을 origin이라는 별명을 가진 원격 저장소의 master branch에 푸시할 거야.
```

아 그러니까, 로컬 브랜치와 원격 브랜치는 아예 관련이 없는 거구나. 이해했다.


## 여러명이 작업하는 경우

* 여러명이 작업하게 되면, 작업을 하고 있는 원격 저장소에 다양한 commit이 올라와 있을 것이다.
* 만약 feature list를 잘 나눠서 작업하고 있다면, 충돌이 날일은 없을 것이고,
* 그렇다면, 작업하기 전에 변경사항을 확인하고, 내 로컬 저장소에 반영한 뒤에 내 작업을 해서 올리는 것이 좋을 것이다.
* 이 작업을 `fetch & pull`라 한다.
* fetch는 확인
* pull은 fetch를 보고, 원격 저장소의 원격 브랜치에서 변경 사항을 적용하는 것을 말함


## 원격 저장소 브랜치 만들기

```bash
git push origin develop # develop이라는 branch를 원격 저장소 origin에 생성함

git branch -a # 로컬, 원격 저장소의 브랜치를 모두 보여줌
# 업데이트하기 위해서는 항상 fetch.

git checkout -b develop origin/develop # develop이라는 로컬 저장소를 만들고, origin에 있는 develop 브랜치의 내용을 받고, 해당 브랜치로 이동해라
```
# fork, Pull Request

* 현재 내가 기여하고 싶은 repo를 clone한다.
* clone하게 되면, 해당 프로젝트의 모든 git log 역시 받아온 상태이다.
* 이 상태에서 내가 추가적으로 기능을 개발한다.
* 그리고 그 기능자체를 내가 기여하고 싶은 원격 저장소의 브랜치에 푸시한다.
* 그리고 내가 변경한 기능을 원격 저장소에 넣고 싶다고 PR을 날린다.
* 그렇게 되면 원격 저장소에서는 이 변화를 감지하고, 해당 사용자가 니 원격 저장소에 이 브랜치에 이러한 코드를 추가하고 싶어한다. 라고 알려준다.
* 이에 관련된 사람들의 허락을 모두 받아야 Merge가 가능한 것!

# 브랜치 전략

* master(배포)
* develop(개발)
* features(기능)
  * 기능 이름
* hotfixes