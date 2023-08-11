//
//  CategoryCollectionViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/04/19.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        colorBackgroundView.clipsToBounds = true
        colorBackgroundView.layer.cornerRadius = 11
    }
}
