
## 创建自定义 UITableViewCell
- 新建 Cocoa Touch Class 文件  
![](Snapshot\snap_02060101.png)

- 选择 UITableViewCell 子类，新建 Class 的名称为 MyOtherCell，勾选“Also create XIB file”    
![](Snapshot\snap_02060102.png) 

- 存放路径  
![](Snapshot\snap_02060103.png)  

- 新建文件在项目文档结构图中的位置  
![](Snapshot\snap_02060104.png)  

- 使用自定义 Cell  
viewDidLoad  
```
 // 注册自定义 Cell
tableView.register(UINib(nibName: String(describing: MyOtherCell.self), bundle: nil), 
forCellReuseIdentifier: String(describing: MyOtherCell.self))
```

tableView(:cellForRowAt)  
```
let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyOtherCell.self)) as! MyOtherCell
```

### 设置自定义 UITableViewCell
- 新增一个Label，字体大小为15，然后新增3个约束（上0 左15 下0）   
![](Snapshot\snap_02060201.png)  

- 勾选“Constraint to margins”是以“Contain View”为约束对象，不勾选是以“My Other Cell”为约束对象，这里去掉勾选    
![](Snapshot\snap_02060202.png)  

- 新增一个UIImageView，然后新增3个约束（右边15，宽8，高14）  
![](Snapshot\snap_02060203.png)  

- 新增垂直约束（0）  
![](Snapshot\snap_02060204.png)  

- 把左边的Label复制一份，移动到右边，然后新增约束（上0 右10 下0）  
![](Snapshot\snap_02060205.png)  

- 把右边Label的字体颜色设置为“Light Gray Color”  
![](Snapshot\snap_02060206.png)  

- 设置自定义属性的label值

tableView(:cellForRowAt)  
```
// 自定义属性
cell.leftLabel?.text = myCellModel.text
cell.rightLabel?.text = myCellModel.grey_text
```

- 设置每行高度
```
 // 设置高度
override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    // 固定高度
    if indexPath.section == 0 {
        return 100
    } else {
        return UITableView.automaticDimension + 50
    }
}
```