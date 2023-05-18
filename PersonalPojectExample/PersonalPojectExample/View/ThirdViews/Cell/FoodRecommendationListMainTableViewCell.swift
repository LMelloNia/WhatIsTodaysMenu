//
//  FoodRecommendationListMainTableViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/04/11.
//

import UIKit

class FoodRecommendationListMainTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
