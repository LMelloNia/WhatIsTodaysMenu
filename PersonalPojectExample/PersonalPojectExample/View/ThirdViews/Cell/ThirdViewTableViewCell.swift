//
//  ThirdViewTableViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/13.
//

import UIKit

class ThirdViewTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodCategoryLabel: UILabel!
    @IBOutlet weak var foodContentView: UIView!
    @IBOutlet weak var foodSelectButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
