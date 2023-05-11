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
    
    override func awakeFromNib() {
        super.awakeFromNib()

        categoryImageView.clipsToBounds = true
        categoryImageView.layer.cornerRadius = 30
    }
}
