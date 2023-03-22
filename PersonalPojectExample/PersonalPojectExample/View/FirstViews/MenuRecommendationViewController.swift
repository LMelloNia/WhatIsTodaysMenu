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
    
    var target: Food?
    var randomFoods: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
