//
//  Food.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/10.
//

import Foundation
import UIKit

class Food {
    var image: [UIImage]
    var name: String
    var country: [Country]
    var numberOfPeoPle: [NumberOfPeople]
    var category: [Category]
    var isAllRandom: Bool
    
    func returnCategoryList() -> String {
        var categoryList = [""]
        let characterSet: CharacterSet = [" "]
        for a in self.category {
            categoryList.append(a.rawValue)
        }
        return categoryList.sorted().joined(separator: " ").trimmingCharacters(in: characterSet)
    }
    
    init(image: [UIImage] = [], name: String, country: [Country], numberOfPeoPle: [NumberOfPeople], category: [Category], isAllRandom: Bool = true) {
        self.image = image
        self.name = name
        self.country = country
        self.numberOfPeoPle = numberOfPeoPle
        self.category = category
        self.isAllRandom = isAllRandom
    }
}


    
    

var foods = [
    Food(image: [UIImage(named: "삼겹살1")!, UIImage(named: "삼겹살2")!, UIImage(named: "삼겹살3")!] ,name: "삼겹살", country: [.korean], numberOfPeoPle: [.couple, .family], category: [.meat]),
    Food(image: [UIImage(named: "짜장면1")!, UIImage(named: "짜장면2")!, UIImage(named: "짜장면3")!], name: "짜장면", country: [.chinese], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle]),
    Food(image: [UIImage(named: "라멘1")!, UIImage(named: "라멘2")!, UIImage(named: "라멘3")!], name: "라멘", country: [.japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle, .meat, .spicy, .soup]),
    Food(image: [UIImage(named: "돈까스1")!, UIImage(named: "돈까스2")!, UIImage(named: "돈까스3")!] ,name: "돈까스", country: [.korean, .japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.meat, .friedFood]),
    Food(image: [UIImage(named: "치즈돈까스1")!, UIImage(named: "치즈돈까스2")!, UIImage(named: "치즈돈까스3")!], name: "치즈돈까스", country: [.korean, .japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.meat, .friedFood, .cheese]),
    Food(image: [UIImage(named: "비빔밥1")!, UIImage(named: "비빔밥2")!, UIImage(named: "비빔밥3")!], name: "비빔밥", country: [.korean], numberOfPeoPle: [.alone, .couple, .family], category: [.rice, .vegetable, .spicy]),
    Food(image: [UIImage(named: "냉면1")!, UIImage(named: "냉면2")!, UIImage(named: "냉면3")!], name: "냉면", country: [.korean], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle, .soup]),
    Food(image: [UIImage(named: "짬뽕1")!, UIImage(named: "짬뽕2")!, UIImage(named: "짬뽕3")!], name: "짬뽕", country: [.chinese], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle, .soup, .spicy]),
    Food(image: [UIImage(named: "탕수육1")!, UIImage(named: "탕수육2")!, UIImage(named: "탕수육3")!], name: "탕수육", country: [.chinese], numberOfPeoPle: [.alone, .couple, .family], category: [.meat, .friedFood]),
    Food(image: [UIImage(named: "회1")!, UIImage(named: "회2")!, UIImage(named: "회3")!], name: "회", country: [.none], numberOfPeoPle: [.alone, .couple, .family], category: [.seafood]),
    Food(image: [UIImage(named: "텐동1")!, UIImage(named: "텐동2")!, UIImage(named: "텐동3")!], name: "텐동", country: [.japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.rice, .friedFood]),
    Food(image: [UIImage(named: "초밥1")!, UIImage(named: "초밥2")!, UIImage(named: "초밥3")!], name: "초밥", country: [.japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.seafood, .rice]),
    Food(image: [UIImage(named: "쭈꾸미볶음1")!, UIImage(named: "쭈꾸미볶음2")!], name: "쭈꾸미볶음", country: [.korean], numberOfPeoPle: [.alone, .couple, .family], category: [.seafood, .spicy, .rice])
]
