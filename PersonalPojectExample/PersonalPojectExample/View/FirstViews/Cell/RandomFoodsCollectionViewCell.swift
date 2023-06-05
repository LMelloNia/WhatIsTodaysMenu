//
//  RandomFoodsCollectionViewCell.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/05/26.
//

import UIKit

class RandomFoodsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var randomMenuImageView: UIImageView!
//    @IBOutlet weak var randomMenuButton: UIButton!
    @IBOutlet weak var foodListAddButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!

    var category: String?
    var target: Food?
    var randomFoods: [Food] = []
    var foodListList: [FoodRecommendationList] = []
    var foodRecommendationListEntity: FoodRecommendationListEntity?

    override func awakeFromNib() {
        super.awakeFromNib()

//        randomMenuImageView.animationImages = CoreDataManager.shared.foodEntitys.map({ foodEntity in
//            guard let imageName = foodEntity.imageName?.components(separatedBy: ", ").randomElement() else {
//                return UIImage(systemName: "star")!
//            }
//            return UIImage(named: imageName)!
//        })
//        randomMenuImageView.animationDuration = 2.0
//        randomMenuImageView.animationRepeatCount = 0
//        randomMenuImageView.startAnimating()
    }

    // MARK: 랜덤 버튼을 눌렀을때 isAllRandom이 설정되어있는 것들중에서 랜덤으로 추천
    @IBAction func pressedRandomMenuButton(_ sender: Any) {
        randomMenuImageView.stopAnimating()
        randomFoods = CoreDataManager.shared.isAllRandomFoods.map { Food(image: ($0.imageName?.components(separatedBy: ", "))!, name: $0.name!, country: [Country.chinese], isAllRandom: $0.favorite) }

        if let target = randomFoods.randomElement() {
            if let imageName = target.imageName.randomElement() {
                randomMenuImageView.image = UIImage(named: imageName)
            }
        }
    }

    // MARK: isAllRandom속성을 false로 만들어 전체 랜덤에서 추천되지 않게 하는것
    @IBAction func removeAllRandom(_ sender: Any) {
        if let target = foods.first(where: { Food in
            Food.name == target?.name
        }) {
            target.isAllRandom = false
            print(target.isAllRandom)
        }
    }
}
