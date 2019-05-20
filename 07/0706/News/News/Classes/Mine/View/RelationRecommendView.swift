//
//  RelationRecommendView.swift
//  News
//
//  Created by CoderDream on 2019/5/20.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class RelationRecommendView: UIView, NibLoadable {
    
    var userCards = [UserCard]()
    
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        collectionView.collectionViewLayout = RelationRecommendFlowLayout()
        collectionView.ymRegisterCell(cell: RelationRecommendCell.self)
        collectionView.delegate = self
        collectionView.dataSource  = self
    }
    
}

extension RelationRecommendView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ymDequeueReusableCell(indexPath: indexPath) as RelationRecommendCell
        cell.userCard = userCards[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

class RelationRecommendFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        itemSize = CGSize(width: 142, height: 190)
        minimumLineSpacing = 10
        sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
