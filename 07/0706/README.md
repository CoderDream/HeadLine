## 705-自定义导航栏(24分钟)

### NavigationBarView
1. 新增NavigationBarView文件和xib

设置 xib 的 
- Class: NavigationBarView
- size: Freeform
- Height: 88

新增一个 UIView
设置约束：
- top: 0
- left: 0
- right: 0
- Height: 44
- Constrain to margins: Uncheck

再增加一个 UIView
设置约束：
- left: 0
- bottom: 0
- right: 0
- Height: 44
- Constrain to margins: Uncheck

设置 Navigation Bar View  和两个 UIView 的背景：  
- Background: Clear Color

在下面的 UIView 中新增一个 Button，并设置属性：

- Type: Custom
- Title Content: Empty
- Image: personal_home_back_white_24x24_

约束：
- left: 15  
- Weith: 35  
- Height: 35
- Vertical in Container: 0

赋值按钮，并修改图片
- Image: new_morewhite_titlebar_22x22_

约束：  
- right: 15

同时选中两个按钮，设置(两个按钮垂直居中-在同一条水平线上)
- Vertical Center: 0 