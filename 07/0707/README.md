## 706-添加相关推荐view(34分钟)

### RelationRecommendView
1. 新增RelationRecommendView文件和xib

设置 xib 的 
- Class: RelationRecommendView
- size: Freeform
- Height: 233

新增一个 Label
设置约束：
- top: 0
- left: 15
- right: 0
- Height: 32
- Constrain to margins: Uncheck
- font size: 14
- Label: 相关推荐

新增一个 Collection View  
- top: 0  
- left: 0  
- bottom: 0  
- right: 0  
- Background: Clear color  
- Scroll Direction: Horizontal  
- Show Horizontal Indicator: Unchecked  
- Show Vertical Indicator: Unchecked  


### 创建 RelationRecommendCell


创建 RelationRecommendCell swift 和 xib

- Width: 142  
- Height: 190  

新增 View  
- top: 0  
- left: 0  
- bottom: 0  
- right: 0  

新增 ImageView  
- top: 10  
- Width: 66
- Height: 66  
- Horizontally in Container: 0 
- Class: AnimatableImageView  
- Mask Type: Circle

将 UserDetailHeaderView.xib 的 vip 图片拷贝过来，粘贴到 View 里面，然后相对上面的图片，设置为 Trailing 和 Bottom

新增 Label  
- top: 5  
- left: 0  
- right: 0  
- Height: 23  
- Alghtment: Center 

新增另一个 Label  
- top: 0 
- left: 0  
- right: 0  
- Height: 23  
- Alghtment: Center 
- Size: 13  
- Lines: 0  


将 UserDetailHeaderView.xib 的 关注 按钮拷贝过来，粘贴到 View 里面
先去掉已有宽度约束，剩余高度约束 28，然后新增约束  
- left: 15  
- right: 15  
- bottom: 10  

接下来设置上面的第二个Label 的 Bottom 约束为 5（相对于关注按钮）

View 的 class 设置为 AnimatableView
- Circle Corner: 5


返回按钮
1. NavigationBarView  
```swift
var goBackButtonClicked: (()->())?

/// 返回按钮点击
@IBAction func returnButtonClicked(_ sender: UIButton) {
    goBackButtonClicked?()
}
```

2. UserDetailViewController.viewDidLoad()

```swift
// 返回按钮
navigationBar.goBackButtonClicked = {
self.navigationController?.popViewController(animated: true)
}
```





