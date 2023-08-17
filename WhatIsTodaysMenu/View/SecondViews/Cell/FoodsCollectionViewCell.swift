//
//  FoodsCollectionViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/04/24.
//

import UIKit

class FoodsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodCategoryLabel: UILabel!
    @IBOutlet weak var isfavoriteButton: UIButton!
    @IBOutlet weak var gradationView: UIView!

    var favorite: Bool?
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

        contentView.layer.shadowColor = UIColor.red.cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 1
        contentView.layer.shadowOffset = CGSize(width: 10, height: 10)
        contentView.layer.shadowPath = nil
        
        gradation(view: gradationView)
        gradationView.alpha = 0.8
    }
    
    @IBAction func removeFromListButtonTapped(_ sender: UIButton) {
        guard let foodEntity else { return }
        guard let favorite else { return }
        if favorite {
            self.favorite = false
            self.isfavoriteButton.setImage(UIImage(systemName: "star"), for: .normal)

            CoreDataManager.shared.updatefavorite(food: foodEntity, favorite: !favorite)
        } else {
            self.favorite = true
            self.isfavoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)

            CoreDataManager.shared.updatefavorite(food: foodEntity, favorite: !favorite)
        }
    }
}
