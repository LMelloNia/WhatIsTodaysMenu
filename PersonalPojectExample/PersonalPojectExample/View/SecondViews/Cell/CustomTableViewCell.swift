//
//  CustomTableViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/08.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodCategoryLabel: UILabel!
    @IBOutlet weak var foodContentView: UIView!
    @IBOutlet weak var isAllRandomButton: UIButton!
    
//    var data: Food?
    var isAllRandom: Bool?
    var foodEntity: FoodEntity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        foodContentView.clipsToBounds = true
        foodContentView.layer.cornerRadius = 20
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
