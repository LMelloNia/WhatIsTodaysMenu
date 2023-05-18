//
//  FoodListFirstTableViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/22.
//

import UIKit

class FoodListFirstTableViewCell: UITableViewCell {

    @IBOutlet weak var foodListImageView: UIImageView!
    @IBOutlet weak var foodListNameLabel: UILabel!
    @IBOutlet weak var foodListDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        foodListImageView.clipsToBounds = true
        foodListImageView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
