Add New Constraints勾选[Constrain to neighbor]相对于Content View约束，如果不勾选，相对于My Other View约束。

左边Label，x:15,y:0,Width:42,Height:43.5


ImageView
Constraints:
- right:15
- Width:8
- Height:14

Add New Alignment Constrains:
- Vertically in Container 0

Right Label:
- top:0
- right:15
- bottom:0

## 分割线

View 
Constraints:  
- left:15
- bottom:0
- right:0
- Height:0.5



## MyConcernCell

MyConcernCell(UICollectionViewCell)

Label
Constraints:  
- left:0
- bottom:0
- right:0
- Height:30

Properties:  
- Alignment: center
- Font: System 12.0

Add New Alignment Constrains:
- Horizontally in Container: 0

Vip ImageView:  
- Height: 15
- Weight: 15 

选中图片，点击右键，拖拽到图片上，选中：Bottom 和 Trailing


Hidden: True

```
import Kingfisher

class MyConcernCell: UICollectionViewCell, RegisterCellOrNib {
    /// 头像
    @IBOutlet weak var avatarImageView: UIImageView!
    /// vip
    @IBOutlet weak var vipImageView: UIImageView!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 新通知
    //@IBOutlet weak var tipsButton: UIButton!
    var myConcern: MyConcern? {
        didSet {
            avatarImageView.kf.setImage(with: URL(string: (myConcern?.icon)!))
            nameLabel.text = myConcern?.name
            if let isVerify = myConcern?.is_verify {
                vipImageView.isHidden = !isVerify
            }
            if let tips = myConcern?.tips {
                //tipsButton.isHidden = !tips
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

```

Size: Freeform
Siderbar: None

ImageView
- Height: 260

Constraints:
- Top: 0
- Left: 0
- Bottom: 0
- Right: 0

Button:
- Left: 0
- Bottom: 0
- Right: 0
- Height: 70

Type: Custom

Title insets: 
- left: -25
- top: 25

Image insets:
- Left: 30
- Top: -25

Right:  
- Top: 0
- Right: 0
- Bottom



Middle
- Top: 0
- Left: 0
- Bottom: 0
- Right: 0

3 Button:
- Equal Weight:


Button：
- 更多登录方式 >
- Background: Black Color
- Alpha: 0.6
- Width: 125
- Height: 28
- Bottom: 20

Add New Alignment Constrains:
- Horizontally in Container: 0


IBAnimatable

Class: AnimatableButton

Corner Radius: 14


Stack View