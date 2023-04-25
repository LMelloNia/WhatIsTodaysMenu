//
//  FoodsCollectionViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/04/24.
//

import UIKit

class FoodsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodCategoryLabel: UILabel!
    @IBOutlet weak var foodContentView: UIView!
    @IBOutlet weak var isAllRandomButton: UIButton!
    
    var isAllRandom: Bool?
    var foodEntity: FoodEntity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        foodImageView.clipsToBounds = true
        foodImageView.layer.cornerRadius = foodImageView.bounds.height / 2
    }
    
    @IBAction func removeFromListButtonTapped(_ sender: UIButton) {
        guard let foodEntity else { return }
        guard let isAllRandom else { return }
        if isAllRandom {
            self.isAllRandom = false
            isAllRandomButton.setTitle("💔", for: .normal)
            
            CoreDataManager.shared.updateIsAllRandom(food: foodEntity, isAllRandom: !isAllRandom)
        } else {
            self.isAllRandom = true
            isAllRandomButton.setTitle("❤️", for: .normal)
            
            CoreDataManager.shared.updateIsAllRandom(food: foodEntity, isAllRandom: !isAllRandom)
        }
    }
}
