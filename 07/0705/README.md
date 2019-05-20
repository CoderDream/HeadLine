## 704-自定义弹出视图(52分钟)
UIViewExtension

### 优化UserDetailBottomView
1. 新增协议
```swift
protocol UserDetailBottomViewDelegate: class {
    /// bottomView 底部按钮的点击
    func bottomView(clicked button: UIButton, bottomTab: BottomTab)
}
```

2. 新增代理变量  
```swift
weak var delegate: UserDetailBottomViewDelegate?
```
    
3. 更新点击事件    
```swift
/// bottomTa 按钮点击事件
@objc func bottomTabButtonClicked(button: UIButton) {
    delegate?.bottomView(clicked: button, bottomTab: bottomTabs[button.tag])
}
```

## 新建 UserDetailBottomPushController
1. 新建控制器  
```swift  
import UIKit
import WebKit

class UserDetailBottomPushController: UIViewController {
    
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView()
        webView.frame = view.bounds
        webView.load(URLRequest(url: URL(string: url!)!))
        view.addSubview(webView)
    }
}
```

2. 显示导航栏，由于在UserDetailViewController隐藏了导航栏，这里要把它显示出来  
```swift  
// 显示导航栏
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
}
```

## 新建 UserDetailBottomPopController 和 storyboard

1. 给 storyboard 新增一个 View Controller，设置类为 UserDetailBottomPopController， id 也为 UserDetailBottomPopController，然后去掉 Safe Area （选择UIView Controller，打开 Show the File inspector 面板，去掉 Use Safe Area Layout Guides 前面的勾选框☑️）

2. 新增一个背景图片视图 UIImageView，设置约束
- top: 0
- Leading(left): -10
- bottom: 0
- Trailing(right): -10

- 设置界面如下：
![](https://raw.githubusercontent.com/CoderDream/HeadLine/master/snapshot/0704001.jpg)

3. 设置背景图片

设置 Slicing 属性：
- Slices: Vertical
- Center: Stretches
 
4. 新增 TableView
- top: 10
- left: 0
- bottom: 15
- right: 0

设置 Row Height: 40
background: clear

5. 详细代码  
```swift
import UIKit

class UserDetailBottomPopController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var children1 = [BottomTabChildren]()
    
    @IBOutlet weak var tableView: UITableView!
    
    var didSelectedChild: ((BottomTabChildren)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return children1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        cell.selectionStyle = .none
        let child = children1[indexPath.row]
        cell.textLabel?.text = child.name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
```

 

## UserDetailViewController


1. 新建扩展

```swift
extension UserDetailViewController: UserDetailBottomViewDelegate {
    // bottomView 底部按钮的点击
    func bottomView(clicked button: UIButton, bottomTab: BottomTab) {
        if bottomTab.children.count == 0 { // 直接跳转到下一控制器

        } else { // 弹出子视图

        }
    }   
}
```

### PopoverAnimator  
```swift
import UIKit

class PopoverAnimator: NSObject {
    
}
```