//
//  MenuRecommendationViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/13.
//

import UIKit

class MenuRecommendationViewController: UIViewController {
    
    @IBOutlet weak var randomMenuImageView: UIImageView!
    @IBOutlet weak var randomMenuButton: UIButton!
    @IBOutlet weak var foodListAddButton: UIButton!

    var category: String?
    var target: Food?
    var randomFoods: [Food] = []
    var foodListList: [FoodRecommendationList] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        randomMenuImageView.clipsToBounds = true
        randomMenuImageView.layer.cornerRadius = 20
        
        // MARK: 옵저버 두번째 추가한 부분
        NotificationCenter.default.addObserver(forName: .list, object: nil, queue: .main) { Notification in
            if let foodList = Notification.userInfo?["name"] as? FoodRecommendationList {
                self.foodListList.append(foodList)
            }
        }
        
        randomMenuImageView.animationImages = CoreDataManager.shared.foodEntitys.map({ foodEntity in
            guard let imageName = foodEntity.imageName?.components(separatedBy: ", ").randomElement() else {
                return UIImage(systemName: "star")!
            }
            return UIImage(named: imageName)!
        })
        randomMenuImageView.animationDuration = 2.0
        randomMenuImageView.animationRepeatCount = 0
        randomMenuImageView.startAnimating()
    }
    
    // MARK: 추천한 메뉴를 음식추천목록에 추가
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recommendToFoodListList" {
            if let vc = segue.destination.children.first as? FoodListViewController {
                vc.foodRecommendationListList = self.foodListList
                vc.target = target
            }
        }
    }
    
    // MARK: 랜덤 버튼을 눌렀을때 isAllRandom이 설정되어있는 것들중에서 랜덤으로 추천
    @IBAction func pressedRandomMenuButton(_ sender: Any) {
        randomMenuImageView.stopAnimating()
        dump(CoreDataManager.shared.isAllRandomFoods)
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

    override func viewWillAppear(_ animated: Bool) {
        guard let category, category != "랜덤" else {
            CoreDataManager.shared.fetchIsAllRandom()
            return
        }
        CoreDataManager.shared.fetchCategory(category: category)
    }
}
