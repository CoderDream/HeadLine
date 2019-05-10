### 602-创建用户详情头部(49分钟) 

创建用户详情控制器

在 Mine -> Controller 中创建 UserDetailViewController 


设置xib文件

- 新增一个Scroll View

- top: 0
- left: 0
- right: 0


- top: 0
- left: 0 
- bottom: 0
- right: 0
- Height: 44



新建 UserDetailHeaderView.swift（UIView）和 UserDetailHeaderView.xib文件，同时指定Custom Class为UserDetailHeaderView，设置属性，Simulated Metrics 的 Size 为： Freeform

imageView
- top: 0
- left: 0
- right: 0
- Height: 146

在下方增加一个View
- top: 0
- left: 0
- bottom: 0
- right: 0

在 View 里面新增一个 ImageView
- top: -36
- left: 15
- Heigth: 72
- Weight: 72

AnimatableImageView

AnimatableImageView
- Corner Radius: 36
- Border Color: White
- Border Width: 1
- Mask Type: Circle

再新增一个ImageView
- Height: 19
- Weight: 19

相对于上面的ImageView （选中ImageView，软化拖拽到上面的ImageView上，然后设置）
- Bottom
- Trailing

all_v_avatar_star_16x16_





新增一个 Button AnimatableButton
- Corner Radius: 5


- top: 15
- right: 15
- Width: 28
- Height: 28

- Type: Custom
- Title: Empty

Image: arrow_up_16_16x14_


关注按钮（和右边的按钮垂直居中）
- right: 5
- Height: 28
- Width: 72
- Color: White
AnimatableButton
- Corner Radius: 5
- Background Coler: Device RGB(230, 100, 95)

关注按钮（和右边的按钮垂直居中）
- right: 5
- Height: 28
- Width: 72
- Color: White
AnimatableButton
- Corner Radius: 5
- Background Coler: Device RGB(230, 100, 95)


- Width: 45
- Height: 28

- Type: Custom
- Title: 发私信
- Size: 14
- Text Color: RGB(72, 100, 145)

新建一个View
- left: 0
- right: 0
- Height: 0

给 关注 按钮新增约束
- bottom: 9

新增 Label
- top: 6
- left: 15


- font size: 15

新增 ImageView，然后设置与左边的Label垂直居中：

- Width: 34
- Height: 14
- left: 5

toutiaohao_34x14_

新增一个Label，相对于头条号左边的Label：
- top: 10
- Leading(拖拽设置)
- Font: 13
- Color: RGB(230, 183, 64)

新增位置按钮：
- top: 10
- Leading(与头条认证Label）
- Height: 20

- Type: Custom
- Font: System 13
- Text Color: Black

描述 Label
- top: 10
- Leading(与地区Button）
- Font: System 13
- Height: 21

展开按钮：
- Left: 0

- Center Vertically(与描述 Label）
- Type: System
- Font: System 13









