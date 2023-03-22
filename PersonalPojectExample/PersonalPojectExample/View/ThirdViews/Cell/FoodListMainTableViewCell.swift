//
//  FoodListMainTableViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/22.
//

import UIKit

class FoodListMainTableViewCell: UITableViewCell {

    @IBOutlet weak var listNameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
