# ๐๐ป ์ค๋์ ์ด๋ํด์ผ์ง OOD ๐๐ปโโ๏ธ

**์ฃผ nํ ์ด๋ ๋ชฉํ๋ฅผ ์ ํ์ฌ ๊ฐ์ธ์ '์ค์ด์(์ค๋ ์ด๋ ์๋ฃ)' ์ ๊ฐํธํ๊ฒ ๊ธฐ๋กํ๋ ์ดํ๋ฆฌ์ผ์ด์์๋๋ค.**

<br/>

## ์ฃผ์ ๊ธฐ๋ฅ

- **์ด๋ ๊ธฐ๋ก** - ํ์์คํฌํ ์ฌ์ง ์ดฌ์์ ํตํด ์ด๋ ์ธ์ฆ ์ฌ์ง์ ์๋ก๋ํ๊ณ , ์ด๋์ข๋ชฉ, ์ด๋๊ฐ๋, ์ฝ๋ฉํธ ๋ฑ์ ๊ธฐ๋กํฉ๋๋ค.

- **์ด๋ ๊ธฐ๋ก ๊ฒ์๋ฌผ ์์ธ์กฐํ**  - ์๋ก๋ํ ๊ธฐ๋ก ๊ฒ์๋ฌผ์ ์กฐํํฉ๋๋ค.

- **์ฃผ๊ฐ ์บ๋ฆฐ๋ ์ด๋ ๊ธฐ๋ก ๊ฒ์๋ฌผ ์กฐํ** - ์ฃผ๊ฐ ์บ๋ฆฐ๋๋ฅผ ๊ธฐ์ค์ผ๋ก ๊ฐ ๋ ์ง๋ณ ๊ฒ์๋ฌผ์ ์กฐํํฉ๋๋ค.

  <br/>



## ๊ฐ๋ฐ ๊ธฐ๊ฐ ๋ฐ ์ฌ์ฉ ๊ธฐ์ 

- **๊ฐ๋ฐ ๊ธฐ๊ฐ** : 21.11.18 ~ 21.12.05
- **์ฌ์ฉ ์คํ** : Storyboard, UIKit, MVC, Codable
- **์ฌ์ฉ ๋ผ์ด๋ธ๋ฌ๋ฆฌ** : Moya, Alamofire, Kingfisher, DropDown
- **์ฌ์ฉ ํด** : Figma, Postman

<br/>

## ์์ด์ดํ๋ ์

<img src="https://user-images.githubusercontent.com/59338503/142009050-d50e586f-d401-4449-ba2f-ed6dbff1132e.png" alt="์์ด์ดํ๋ ์" style="zoom:100%;"/>
<br/>

## ์ ๋ณด๊ตฌ์กฐ๋

<img src="https://user-images.githubusercontent.com/59338503/142167924-62fafc74-8a84-4321-862a-b973ca6c36fb.png" alt="์ ๋ณด๊ตฌ์กฐ๋" width="90%" height="90%"/>

<br/>



## ์ด์ ๋ฐ ํด๊ฒฐ

**ScrollView ๋ด์ ์คํฌ๋กค ๋ฐฉํฅ์ด ์ธ๋ก์ธ CollectionView๋ฅผ ๋ฐฐ์นํ์ ๋ CollectionView๋ง ์คํฌ๋กค ๋๋ ์ด์**

```swift
self.collectionViewHeight.constant = self.certiCollectionView.contentSize.height
```

ScrollView๋ contentLayoutGuide๋ฅผ ํตํด ์์ ์ content size๋ฅผ ์ ํํ ์์์ผ ๊ทธ์ ๋ฐ๋ผ ๋์ด๋๊ธฐ ๋๋ฌธ์,

์๋ฒ ํต์  ํ ๋ถ๋ฌ์จ ๊ฒฐ๊ณผ์ ๋ฐ๋ผ CollectionView cell ํน์ layout์ ๋ฐ๋ผ ์ ํด์ง CollectionView์ ์ ์ฒด ๋์ด content size.height ๋ฅผ ๊ฐ์ ธ์ CollectionView ์ ๋์ด auto layout์ ๋ณ๊ฒฝํด์ฃผ์ด ํด๊ฒฐ

<br/>

**์๋ฒ ์ฐ๊ฒฐ ํ CollectionView cell์ ๊ฒฐ๊ณผ๊ฐ์ ๋์ธ ๋ CollectionView height ๊ฐฑ์  ์์  ์ด์**

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

viewDidLoad()์ ์์นํ๋ *self.collectionViewHeight.constant = self.certiCollectionView.contentSize.height* ์ ์๋ฒํต์ ์ผ๋ก ๋ฐ์์ค๋ CollectionView Cell ์ ๋ณด์ ๋ฐฐ์ด์ธ certiListData์ ํ๋กํผํฐ์ต์ ๋ฒ didSet์ผ๋ก ์ฎ๊ฒจ ํด๊ฒฐ





## View

- **์คํ๋์ฌ ๋ฐ ๋ก๊ทธ์ธ & ํ์๊ฐ์**

<img src="https://user-images.githubusercontent.com/59338503/142013005-3ff7c0ac-d936-40af-ab58-413099293162.png" alt="์คํ๋์๋ก๊ทธ์ธ" width="40%" height="40%"/><img src="https://user-images.githubusercontent.com/59338503/142012560-1c9708b5-5eda-483f-933a-e51eb7f1cc75.png" alt="ํ์๊ฐ์" width="50%" height="50%"/>



<br/>

- **์ฃผ๊ฐ ์บ๋ฆฐ๋ ์ด๋ ๊ธฐ๋ก ์กฐํ**

  > ๊ธฐ๋ก ๊ฒ์๋ฌผ์ ์๋ก๋ ํ  ์ ์๋ **+ ๋ฒํผ**๊ณผ ๋ค๋น๊ฒ์ด์ ๋ฐ์ **๋ง์ดํ์ด์ง ๋ฒํผ**

<img src="https://user-images.githubusercontent.com/59338503/142013433-d9ca906c-a86c-4ac7-8789-93e80a8c32f8.png" alt="์ฃผ๊ฐ์บ๋ฆฐ๋" width="40%" height="40%"/>

<br/>

- **์ด๋ ๊ธฐ๋ก**

  > ํ์์คํฌํ ์ฌ์ง + ์ด๋ ์๊ฐ + ์ด๋ ์ข๋ชฉ + ์ด๋ ๊ฐ๋ + ์ด๋ ํ๊ฐ ์๋ ฅ

<img src="https://user-images.githubusercontent.com/59338503/142013741-8007d959-292c-4a0f-998b-919a350344d3.png" alt="์ด๋๊ธฐ๋ก" width="60%" height="60%"/>

<br/>

- ์ด๋ ๊ธฐ๋ก ์์ธ์กฐํ

  > ๊ธฐ๋ก ์์ธ ์กฐํ ๋ฐ ์์ /์ญ์ 

<img src="https://user-images.githubusercontent.com/59338503/142013791-99aa3022-1a2e-4239-a246-910a0b3a8714.png" alt="์ด๋๊ธฐ๋ก์์ธ์กฐํ" width="20%" height="20%"/>

<br/>

- ๋ง์ดํ์ด์ง & ์ค์ 

  > ๋ชฉํ ์ด๋ ํ์ ๊ธฐ์ค ํ์ฌ ๋ฌ์ฑ๋ฅ  / ์ด ๊ธฐ๋ก ํ์ / ์ด ๊ธฐ๋ก ๊ฒ์๋ฌผ ์กฐํ

<img src="https://user-images.githubusercontent.com/59338503/142013538-a8b95e0a-12d2-4b3a-a260-07977b3d0e74.png" alt="๋ง์ดํ์ด์ง์ค์ " width="40%" height="40%"/>