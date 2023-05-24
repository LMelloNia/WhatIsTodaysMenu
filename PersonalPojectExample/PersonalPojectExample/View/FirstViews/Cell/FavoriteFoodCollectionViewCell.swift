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

    var favorite: Bool?
    var foodEntity: FoodEntity?

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

    @IBAction func removeFromListButtonTapped(_ sender: UIButton) {
        guard let foodEntity else { return }
        guard let favorite else { return }
        if favorite {
            self.favorite = false
            self.isAllRandomButton.setImage(UIImage(systemName: "star"), for: .normal)

            CoreDataManager.shared.updatefavorite(food: foodEntity, favorite: !favorite)
        } else {
            self.favorite = true
            self.isAllRandomButton.setImage(UIImage(systemName: "star.fill"), for: .normal)

            CoreDataManager.shared.updatefavorite(food: foodEntity, favorite: !favorite)
        }
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
