//
//  MyFirstSectionCell.swift
//  News
//
//  Created by CoderDream on 2019/4/30.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

protocol MyFirstSectionCellDelegate: class {
    func MyFirstSectionCell(_ firstCell: MyFirstSectionCell, myConcern: MyConcern)
}

class MyFirstSectionCell: UITableViewCell, RegisterCellOrNib {
    
    var delegate: MyFirstSectionCellDelegate?
    
    /// 标题
    @IBOutlet weak var leftLabel: UILabel!
    /// 副标题
    @IBOutlet weak var rightLabel: UILabel!
    /// 右边箭头
    @IBOutlet weak var rightImageView: UIImageView!
    // 集合视图
    @IBOutlet weak var collectionView: UICollectionView!
    /// 顶部视图
    @IBOutlet weak var topView: UIView!
    /// 分割线
    @IBOutlet weak var separatorView: UIView!
    
    //@IBOutlet var contentView: UIView!
    /// 我关注的用户
    var myConcerns = [MyConcern]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var myCellModel: MyCellModel? {
        didSet {
            leftLabel.text = myCellModel?.text
            rightLabel.text = myCellModel?.grey_text
        }
    }
    
    var myConcern: MyConcern? {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("My First Section Cell")
        collectionView.collectionViewLayout = MyConcernFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.ymRegisterCell(cell: MyConcernCell.self)
        // 设置主题
        leftLabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.cellRightTextColor"
        rightImageView.theme_image = "images.cellRightArrow"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
        topView.theme_backgroundColor = "colors.separatorViewColor"
        collectionView.theme_backgroundColor = "colors.separatorViewColor"
        backgroundView?.theme_backgroundColor = "colors.black"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension MyFirstSectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myConcerns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ymDequeueReusableCell(indexPath: indexPath) as MyConcernCell
        cell.myConcern = myConcerns[indexPath.item]
        return cell
    }
    // 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myConcern = myConcerns[indexPath.item]
        delegate?.MyFirstSectionCell(self, myConcern: myConcern)
    }
}

class MyConcernFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        // 每个 cell 的大小
        itemSize = CGSize(width: 58, height: 74)
        // 横向间距
        minimumLineSpacing = 0
        // 纵向间距
        minimumInteritemSpacing = 0
        // cell 上下左右的间距
        sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        // 设置水平滚动
        scrollDirection = .horizontal
    }
}
