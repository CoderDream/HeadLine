
在 Mine -> Controller 文件夹下新建一个 UITableViewController，名称为 SettingViewController

拷贝 navigation 图片到资源文件夹 Assets.xcassets


打开 Assets 文件夹，选中需要设置的图片，在右边的设置窗口进行设置：

设置为原始格式（如果不设置，系统会默认渲染成蓝色箭头，图片的原始颜色为黑色）

在 Main -> Controller 下的 MyNavigationController 进行设置，添加如下代码：
```swift
// 拦截 push 操作
override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    if viewControllers.count > 0 {
        // 隐藏底部栏
        viewController.hidesBottomBarWhenPushed = true
        // 设置左上角的按钮
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_24x24_"), style: .plain, target: self, action: #selector(navigationBack))
    }
    // 必须放在后面
    super.pushViewController(viewController, animated: true)
}

/// 返回上一级控制器
@objc private func navigationBack() {
    popViewController(animated: true)
}

```


## SettingCell

Label
- top: 0
- bottom: 0
- left: 15

size: 15

Label
leading to the first Label
- bottom: 0
- Height: 0
- Label: Empty
- Color: RGB(232, 84, 85)

Right Label
- top: 0
- right: 15
- bottom: 0
- size: 14
- Color: Light Gray
- Label: Empty

从MyOtherCell.xib中拷贝右边图片，粘贴到SettingCell.xib中，然后选择该图片，拖拽到右边的Label上，选择“Trailing”，然后设置垂直居中（Vertically in Container： 0）

同样的方式添加 Switch，默认设置为 Off（State:Off）

再添加一个分割线（View）
然后选择该View，拖拽到最上面的Label上，选择“Leading”
设置约束：
- right: 0
- bottom: 0
- Height: 0
- Color: RGB(240, 240, 24040)