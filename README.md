![0 planfit](https://github.com/NOW-SOPT-APP3-PlanFit/PlanFit-iOS/assets/144984293/77dadc36-4703-4754-aba4-f43476e31858)
```
운동이 쉬워진다. 플랜핏 하나면 운동 고민 끝 🏋️
34기 NOW SOPT 합동세미나 앱 3팀 PlanFit 프로젝트입니다.
```
</br>


![1 iOS developer](https://github.com/NOW-SOPT-APP3-PlanFit/PlanFit-iOS/assets/144984293/849236a1-cf7a-4afb-a943-ad881e8b0d60)
|🔖 김진웅</br>[@JinUng41](https://github.com/JinUng41)|🔖 왕정빈</br>[@kingjeongkong](https://github.com/kingjeongkong)|🔖 김수연</br>[@mmaybei](https://github.com/mmaybei)|
|:---:|:---:|:---:|
|<img src = "https://github.com/NOW-SOPT-APP3-PlanFit/PlanFit-iOS/assets/144984293/df15f3cf-5bbc-497d-87c7-f6efeb37a9c7" width ="250">|<img src = "https://github.com/NOW-SOPT-APP3-PlanFit/PlanFit-iOS/assets/144984293/1179e13a-72f3-44dd-a82d-58263b5283e4" width ="250">|<img src = "https://github.com/NOW-SOPT-APP3-PlanFit/PlanFit-iOS/assets/144984293/5eff0e32-5c6e-4fa8-a904-3a57105badc5" width ="250">|
|`홈 화면 뷰`</br>`웜업 스트레칭 뷰`|`근력 운동 뷰`|`추천 운동 리스트 뷰`|
</br>


![3 Commit convention](https://github.com/NOW-SOPT-APP3-PlanFit/PlanFit-iOS/assets/144984293/8847928c-abdd-4540-a3fe-797860f81cad)
```
- [feat] : 주로 사용자에게 새로운 기능이 추가되는 경우
- [fix] : 사용자가 사용하는 부분에서 bug가 수정되는 경우
- [docs] : 문서에 변경 사항이 있는 경우
- [config] : 프로젝트 초기 설정 시
- [style] : 세미콜론을 까먹어서 추가하는 것 같이 형식적인 부분을 다루는 경우 (코드의 변화가 생산적인 것이 아닌 경우)
- [refactor] : production code를 수정하는 경우 (변수의 네이밍을 수정하는 경우)
- [chore] : 별로 중요하지 않은 일을 수정하는 경우 (코드의 변화가 생산적인 것이 아닌 경우)
- [design] : UI 디자인을 변경했을 때
```
```
이슈 번호를 붙여 다음과 같이 작성한다.
[Config/#1] 이미지 에셋 추가
[Feat/#1] 로그인 화면 구현
```
</br>


![4 Foldering](https://github.com/NOW-SOPT-APP3-PlanFit/PlanFit-iOS/assets/144984293/3b2126dd-3707-4391-9f93-0ca1bef2d3ec)
```
📦 PlanFit
┣ 📂 App
┃ ┣ 📜 Appdelegate
┃ ┣ 📜 SceneDelegate
┃
┣ 📂 Common
┃ ┣ 📂 Extension
┃ ┣ 📂 Util
┃ ┃ ┣ 📜 ReuseIdentifiable
┃ ┃ ┣ 📜 Screen
┃ ┃ ┣ 📜 Then
┃ ┃
┃ ┣ 📂 Resources
┃ ┃ ┣ 📜 Assets
┃ ┃ ┣ 📜 PlanFitColor
┃ ┃ ┣ 📜 LaunchScreen
┃ ┃ ┣ 📜 ViewController
┃ ┃ ┣ 📜 Info.plist
┃
┣ 📂 Presentation
┃ ┣ 📂 Home
┃ ┣ 📂 WorkoutList
┃ ┃ ┃ ┣ 📂 View
┃ ┃ ┃ ┃ ┣ 📜 WorkoutListView
┃ ┃ ┃ ┃ ┣ 📜 WorkoutListViewCell
┃ ┃ ┃ ┣ 📂 Controller
┃ ┃ ┃ ┃ ┣ 📜 WorkoutListViewController
┃ ┣ 📂 WarmUp
┃ ┣ 📂 Workout
┃
┣ 📂 Network
```
