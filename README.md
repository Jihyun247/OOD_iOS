# 🏃🏻 오늘은 운동해야지 OOD 🏃🏻‍♀️

**주 n회 운동 목표를 정하여 개인의 '오운완(오늘 운동 완료)' 을 간편하게 기록하는 어플리케이션입니다.**

<br/>

## 주요 기능

- **운동 기록** - 타임스탬프 사진 촬영을 통해 운동 인증 사진을 업로드하고, 운동종목, 운동강도, 코멘트 등을 기록합니다.

- **운동 기록 게시물 상세조회**  - 업로드한 기록 게시물을 조회합니다.

- **주간 캘린더 운동 기록 게시물 조회** - 주간 캘린더를 기준으로 각 날짜별 게시물을 조회합니다.

  <br/>



## 개발 기간 및 사용 기술

- **개발 기간** : 21.11.18 ~ 21.12.05
- **사용 스택** : Storyboard, UIKit, MVC, Codable
- **사용 라이브러리** : Moya, Alamofire, Kingfisher, DropDown
- **사용 툴** : Figma, Postman

<br/>

## 와이어프레임

<img src="https://user-images.githubusercontent.com/59338503/142009050-d50e586f-d401-4449-ba2f-ed6dbff1132e.png" alt="와이어프레임" style="zoom:100%;"/>
<br/>

## 정보구조도

<img src="https://user-images.githubusercontent.com/59338503/142167924-62fafc74-8a84-4321-862a-b973ca6c36fb.png" alt="정보구조도" width="90%" height="90%"/>

<br/>



## 이슈 및 해결

**ScrollView 내에 스크롤 방향이 세로인 CollectionView를 배치했을 때 CollectionView만 스크롤 되는 이슈**

```swift
self.collectionViewHeight.constant = self.certiCollectionView.contentSize.height
```

ScrollView는 contentLayoutGuide를 통해 자신의 content size를 정확히 알아야 그에 따라 늘어나기 때문에,

서버 통신 후 불러온 결과에 따라 CollectionView cell 혹은 layout에 따라 정해진 CollectionView의 전체 높이 content size.height 를 가져와 CollectionView 의 높이 auto layout을 변경해주어 해결

<br/>

**서버 연결 후 CollectionView cell에 결과값을 띄울 때 CollectionView height 갱신 시점 이슈**

```swift
var certiListData: [CertiListData] = [] {
        didSet {
            certiCollectionView.reloadData()
            DispatchQueue.main.async {
                self.collectionViewHeight.constant = self.certiCollectionView.contentSize.height
            }
        }
}
```

viewDidLoad()에 위치했던 *self.collectionViewHeight.constant = self.certiCollectionView.contentSize.height* 을 서버통신으로 받아오는 CollectionView Cell 정보의 배열인 certiListData의 프로퍼티옵저버 didSet으로 옮겨 해결





## View

- **스플래쉬 및 로그인 & 회원가입**

<img src="https://user-images.githubusercontent.com/59338503/142013005-3ff7c0ac-d936-40af-ab58-413099293162.png" alt="스플래시로그인" width="40%" height="40%"/><img src="https://user-images.githubusercontent.com/59338503/142012560-1c9708b5-5eda-483f-933a-e51eb7f1cc75.png" alt="회원가입" width="50%" height="50%"/>



<br/>

- **주간 캘린더 운동 기록 조회**

  > 기록 게시물을 업로드 할 수 있는 **+ 버튼**과 네비게이션 바에 **마이페이지 버튼**

<img src="https://user-images.githubusercontent.com/59338503/142013433-d9ca906c-a86c-4ac7-8789-93e80a8c32f8.png" alt="주간캘린더" width="40%" height="40%"/>

<br/>

- **운동 기록**

  > 타임스탬프 사진 + 운동 시간 + 운동 종목 + 운동 강도 + 운동 평가 입력

<img src="https://user-images.githubusercontent.com/59338503/142013741-8007d959-292c-4a0f-998b-919a350344d3.png" alt="운동기록" width="60%" height="60%"/>

<br/>

- 운동 기록 상세조회

  > 기록 상세 조회 및 수정/삭제

<img src="https://user-images.githubusercontent.com/59338503/142013791-99aa3022-1a2e-4239-a246-910a0b3a8714.png" alt="운동기록상세조회" width="20%" height="20%"/>

<br/>

- 마이페이지 & 설정

  > 목표 운동 횟수 기준 현재 달성률 / 총 기록 횟수 / 총 기록 게시물 조회

<img src="https://user-images.githubusercontent.com/59338503/142013538-a8b95e0a-12d2-4b3a-a260-07977b3d0e74.png" alt="마이페이지설정" width="40%" height="40%"/>