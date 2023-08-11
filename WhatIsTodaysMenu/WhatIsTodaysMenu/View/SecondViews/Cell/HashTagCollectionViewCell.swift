//
//  HashTagCollectionViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/05/11.
//

import UIKit

class HashTagCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var hashTagLabel: UILabel!
    @IBOutlet weak var hashTagContentView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
    }
}
