## 707-导航栏补充(13分钟)

关注页面上推后显示名字

打开 NavigationBarView.xib 新建 Label 设置约束
居中
- H in Container: 0
- V in Container: 0

- Width: 70
- Alignment: Center

从 UserDetailHeaderView.xib 文件拷贝 关注 按钮过来，然后设置与 Label 水平居中，Label在左边10，然后将两个控件的Hidden默认值勾选☑️