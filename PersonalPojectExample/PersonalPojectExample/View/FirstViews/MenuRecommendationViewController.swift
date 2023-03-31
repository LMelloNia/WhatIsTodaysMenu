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
    
    var target: Food?
    var randomFoods: [Food] = []
    var foodListList: [FoodList] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: 옵저버 두번째 추가한 부분
        NotificationCenter.default.addObserver(forName: .list, object: nil, queue: .main) { Notification in
            if let foodList = Notification.userInfo?["name"] as? FoodList {
                self.foodListList.append(foodList)
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recommendToFoodListList" {
            if let vc = segue.destination.children.first as? FoodListViewController {
                
                vc.foodListList = self.foodListList
                vc.target = target
                dump(target)
            }
        }
    }
    
    
    @IBAction func pressedRandomMenuButton(_ sender: Any) {
        let randomFoods = foods.filter { Food in
            Food.isAllRandom == true
        }
        
        target = randomFoods.randomElement()
        randomMenuImageView.image = target?.image.randomElement()
    }
    
    @IBAction func removeAllRandom(_ sender: Any) {
        if let target = foods.first(where: { Food in
            Food.name == target?.name
        }) {
            target.isAllRandom = false
            print(target.isAllRandom)
        }
    }
}
