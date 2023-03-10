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

let foodImageList = [
    [UIImage(named: "삼겹살1")!, UIImage(named: "삼겹살2")!, UIImage(named: "삼겹살3")!],
    [UIImage(named: "짜장면1")!],
    [UIImage(named: "라멘1")!, UIImage(named: "라멘2")!, UIImage(named: "라멘3")!]
]

var foodList = [
    Food(image: foodImageList[0] ,name: "삼겹살", country: [.korean], numberOfPeoPle: [.couple, .family], category: [.meat]),
    Food(image: foodImageList[1], name: "짜장면", country: [.chinese], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle]),
    Food(image: foodImageList[2], name: "라멘", country: [.japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle, .meat, .spicy, .soup]),
    Food(name: "돈까스", country: [.korean, .japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.meat, .friedFood]),
    Food(name: "치즈 돈까스", country: [.korean, .japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.meat, .friedFood, .cheese]),
    Food(name: "비빔밥", country: [.korean], numberOfPeoPle: [.alone, .couple, .family], category: [.rice, .vegetable, .spicy]),
    Food(name: "냉면", country: [.korean], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle, .soup]),
    Food(name: "짬뽕", country: [.chinese], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle, .soup, .spicy]),
    Food(name: "탕수육", country: [.chinese], numberOfPeoPle: [.alone, .couple, .family], category: [.meat, .friedFood]),
    Food(name: "회", country: [.none], numberOfPeoPle: [.alone, .couple, .family], category: [.seafood]),
    Food(name: "텐동", country: [.japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.rice, .friedFood]),
    Food(name: "초밥", country: [.japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.seafood, .rice]),
    Food(name: "쭈꾸미볶음", country: [.korean], numberOfPeoPle: [.alone, .couple, .family], category: [.seafood, .spicy, .rice])
]
