---
layout: post
title: "Commit Convention"
category: "DV/iOS"
comments: true
tags: [commit, git]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
summary: "Commit Convention 정리"
---

# 커밋 메시지 구조

```
type : subject

body

footer
```

# Commit type

* feat: 새로운 기능 추가
* fix: 버그 수정
* docs: 문서 수정
* style: 코드 포맷팅, 세미콜로 누락, 코드 변경이 없는 경우
* refactor: 리팩토링
* test: 테스트 코드, 리팩토링 테스트 코드 추가
* chore: 빌드 업무 수정, 패키지 매니저 수정
  * 따분한 일이라는 뜻..


# Subject  

* 제목 50자 안으로
* 대문자로 작성
* 마침표 X
* 명령어로 작성

# Body

* 선택 사항
* 부연 설명 필요한 경우 작성
* 한칸 띄우고 작성


# Footer

* issue tracker id 작성할 때 사용

# Example

```
feat: Summarize changes in around 50 characters or less

More detailed explanatory text, if necessary. Wrap it to about 72
characters or so. In some contexts, the first line is treated as the
subject of the commit and the rest of the text as the body. The
blank line separating the summary from the body is critical (unless
you omit the body entirely); various tools like `log`, `shortlog`
and `rebase` can get confused if you run the two together.

Explain the problem that this commit is solving. Focus on why you
are making this change as opposed to how (the code explains that).
Are there side effects or other unintuitive consequenses of this
change? Here's the place to explain them.

Further paragraphs come after blank lines.

 - Bullet points are okay, too

 - Typically a hyphen or asterisk is used for the bullet, preceded
   by a single space, with blank lines in between, but conventions
   vary here

If you use an issue tracker, put references to them at the bottom,
like this:

Resolves: #123
See also: #456, #789
```
