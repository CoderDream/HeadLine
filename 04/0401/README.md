
Button
- top: 10
- right: 10

Constrain to margins: (Checked)
- Weight: 24
- Height: 24

Type: Custom
Title: (Empty)

Label
- Top: 48
- Left: 0
- Right: 0

View
- Top: 35
- Left: 30
- right: 30
- Height: 40

- Class: AnimatableView
- Corner Radius: 22
- Border Color: Light Gray Color
- Border Width: 1

New View
- Top: 0
- right: 0
- bottom: 0
Constrain to margins: (Unchecked)
- Width: 95

- Background: Clear Color

View()
- Top: 10
- Left: 0
- Bottom: 10

Constrain to margins: (Unchecked)
- Width: 1
- Background: Light Gray Color


Button
- top: 0
- left: 0
- bottom: 0
- right: 0

Type: Custom
Size: 13
Title: 发送验证码
Color: Black(RGB Slider 0,0,0) Opacity: 70%

Text Field:
- top: 0
- left: 12
- bottom: 0
- right: 0

Border Style: First One(第一个，虚线)
Clear Button: Appears while editing
Placeholder: 手机号

将 Animatable View 命名为【手机号】，然后拷贝，粘贴，命名为【验证码】

- top: 10

- Hor 0

选中两个，然后增加等宽等高的约束：
- Equal Widths
- Equal Heights

   
Label
- top: 10
- left: 0
- right: 0

未注册手机验证后登录
size: 13
Align: Center
Color: Light Gray Color

Button
（与验证码等宽等高）
- Top: 10

- Class: AnimatableButton

Corner Radius: 22
Background: Custom(RGB Slider 249,169,169) 
Type: Custom
Title: 进入头条

Label:
- top: 10
- 我已阅读并同意“用户协议和隐私条款”

Button
- right: 5

Type: Custom
Title: (Empty)
Image: details_choose_ok_icon_15x15_

Label 和 Button 垂直居中
Add New Alignment Constraints
- Vertical Centers: 0


Button
- top: 30

Type: Custom
Title: 账号密码登录
Color: Custom(RGB Slider 72,107,157) 
Size: 13



Button(微信)

Type: Custom
Title: (Empty)
Image: weixin_sdk_login_40x40_

水平居中
- bottom: 40

- Stack View 与 【进入头条】按钮等宽
- 四个按钮等宽

More Login View Controller
- Modal Position: BottomCenter
- Corner Radius: 15






（）