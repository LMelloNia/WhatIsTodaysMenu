//
//  FoodChooseCollectionViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/05/16.
//

import UIKit

class FoodChooseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodCategoryLabel: UILabel!
    @IBOutlet weak var isAllRandomButton: UIButton!
    @IBOutlet weak var gradationView: UIView!
    @IBOutlet weak var checkImageView: UIImageView!

    let colors = [
        UIColor.clear.cgColor,
        UIColor.black.cgColor
    ]

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        gradation(view: gradationView)
        gradationView.alpha = 0.8
    }

    func gradation(view: UIView) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.colors = colors
        gradient.type = .axial
        view.layer.addSublayer(gradient)
    }
}
