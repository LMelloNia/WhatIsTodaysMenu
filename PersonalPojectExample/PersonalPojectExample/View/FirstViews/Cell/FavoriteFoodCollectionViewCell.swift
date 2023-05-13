//
//  FavoriteFoodCollectionViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/05/11.
//

import UIKit

class FavoriteFoodCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodCategoryLabel: UILabel!
    @IBOutlet weak var isAllRandomButton: UIButton!
    @IBOutlet weak var gradationView: UIView!


    var love: Bool?
    var foodEntity: FoodEntity?

    let colors = [
        UIColor.clear.cgColor,
        UIColor.black.cgColor
    ]

    func gradation(view: UIView) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.colors = colors
        gradient.type = .axial
        view.layer.addSublayer(gradient)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        gradation(view: gradationView)
    }

    @IBAction func removeFromListButtonTapped(_ sender: UIButton) {
        guard let foodEntity else { return }
        guard let love else { return }
        if love {
            self.love = false
            self.isAllRandomButton.setImage(UIImage(systemName: "heart"), for: .normal)

            CoreDataManager.shared.updateLove(food: foodEntity, love: !love)
        } else {
            self.love = true
            self.isAllRandomButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)

            CoreDataManager.shared.updateLove(food: foodEntity, love: !love)
        }
    }
}
