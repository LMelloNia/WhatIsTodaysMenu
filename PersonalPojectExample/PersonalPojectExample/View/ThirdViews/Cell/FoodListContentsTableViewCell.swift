//
//  FoodListContentsTableViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/22.
//

import UIKit

class FoodListContentsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBOutlet weak var foodNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
