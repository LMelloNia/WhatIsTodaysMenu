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

        mainImageView.alpha = 0.7
    }

    func setUpUI() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false

        if contentView.bounds.width < 395 {
            mainImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0).isActive = true
            mainImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        } else {
//            mainImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0).isActive = true
//            mainImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6).isActive = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
