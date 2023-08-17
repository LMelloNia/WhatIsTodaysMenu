//
//  FoodRecommendationListFoodTableViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/04/11.
//

import UIKit

class FoodRecommendationListFoodTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
