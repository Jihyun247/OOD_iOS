# SeSAC_Project1
<br/>


## 오늘은 운동해야지 (OOD)
<br/>


### [서비스 소개]

> 주 n회 운동 목표를 정하여 개인의 **'오운완(오늘 운동 완료)'** 을 기록하는 어플리케이션입니다.

<br/>



### [기획 의도]

> 주 n회 운동을 목표로 잡고 달성률을 채우며 운동 습관을 만들고, 하루하루 어떤 운동을 얼만큼 어떤 강도로 얼마나 만족스럽게 수행했는지 간편하게 기록할 수 있는 어플리케이션이 있으면 좋겠다고 생각하여 기획하게 되었습니다.

<br/>




### [주요 기능]

1. **운동 기록** - 타임스탬프 사진 촬영을 통해 운동 인증 사진을 업로드하고, 운동종목, 운동강도, 코멘트 등을 기록합니다.

2. **운동 기록 게시물 상세조회**  - 업로드 한 기록 게시물을 조회합니다.

3. **주간 캘린더 운동 기록 게시물 조회** - 주간 캘린더를 기준으로 각 날짜별 게시물을 조회합니다.

  <br/>




### [와이어프레임]

<img src="https://user-images.githubusercontent.com/59338503/142009050-d50e586f-d401-4449-ba2f-ed6dbff1132e.png" alt="와이어프레임" style="zoom:100%;"/>
figma : https://www.figma.com/file/IuRK0VwACUUGyZwmnBG0v4/?node-id=1205%3A1637
<br/>



### [정보구조도 및 기능명세서]

<img src="https://user-images.githubusercontent.com/59338503/142167924-62fafc74-8a84-4321-862a-b973ca6c36fb.png" alt="정보구조도" width="90%" height="90%"/>




### [View]

#### 1. 스플래쉬 & 로그인 & 회원가입
<img src="https://user-images.githubusercontent.com/59338503/142013005-3ff7c0ac-d936-40af-ab58-413099293162.png" alt="스플래시로그인" width="40%" height="40%"/><img src="https://user-images.githubusercontent.com/59338503/142012560-1c9708b5-5eda-483f-933a-e51eb7f1cc75.png" alt="회원가입" width="50%" height="50%"/>

> **회원가입 View** : 닉네임, 아이디(email로 수정 예정), 비밀번호 + 일주일 목표 운동 횟수
>
> **로그인 View** : 아이디 찾기 및 비밀번호 찾기는 추후 업데이트 요소로 결정 
>
> -> 회원가입 뷰 하나로 줄일 것

<br/>



#### 2. 주간 캘린더 운동 기록 조회
<img src="https://user-images.githubusercontent.com/59338503/142013433-d9ca906c-a86c-4ac7-8789-93e80a8c32f8.png" alt="주간캘린더" width="40%" height="40%"/>

> **주간 캘린더 운동 기록 조회 View** : 날짜별 기록 게시물을 조회하는 view
>
>  기록 게시물을 업로드 할 수 있는 **+ 버튼**과 네비게이션 바에 **마이페이지 버튼** 존재

<br/>



#### 3. 운동 기록
<img src="https://user-images.githubusercontent.com/59338503/142013741-8007d959-292c-4a0f-998b-919a350344d3.png" alt="운동기록" width="60%" height="60%"/>

> **운동 기록 업로드 View** : 타임스탬프 사진 + 운동 시간 + 운동 종목 + 운동 강도 + 운동 평가 입력

<br/>



#### 4. 운동 기록 상세조회
<img src="https://user-images.githubusercontent.com/59338503/142013791-99aa3022-1a2e-4239-a246-910a0b3a8714.png" alt="운동기록상세조회" width="20%" height="20%"/>

> **운동 기록 상세조회 View** : 기록 상세 조회 및 수정/삭제

<br/>



#### 5. 마이페이지 & 설정

<img src="https://user-images.githubusercontent.com/59338503/142013538-a8b95e0a-12d2-4b3a-a260-07977b3d0e74.png" alt="마이페이지설정" width="40%" height="40%"/>

> **마이페이지 View** : 목표 운동 횟수 기준 현재 달성률 / 총 기록 횟수 / 총 기록 게시물 조회
>
> -> 시간 모자르다면 설정뷰와 합칠 예정

<br/>



### Notion Page

>  https://github.com/Jihyun247/SeSAC_Project1.git

