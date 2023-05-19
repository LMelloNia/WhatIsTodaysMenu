//
//  Food.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/10.
//

import Foundation
import UIKit

class Food {
    var imageName: [String]
    var name: String
    var country: [Country]?
    var numberOfPeoPle: [NumberOfPeople]
    var category: [Category]
    var isAllRandom: Bool
    var isChecked: Bool = false
    var favorite: Bool
    var categoryList: String {
        var categoryList = [""]
        let characterSet: CharacterSet = [" "]
        for category in self.category {
            categoryList.append(category.rawValue)
        }
        return categoryList.sorted().joined(separator: " ").trimmingCharacters(in: characterSet)
    }
    
//    func returnCategoryList() -> String {
//        var categoryList = [""]
//        let characterSet: CharacterSet = [" "]
//        for a in self.category {
//            categoryList.append(a.rawValue)
//        }
//        return categoryList.sorted().joined(separator: " ").trimmingCharacters(in: characterSet)
//    }
    
    init(image: [String] = [], name: String, country: [Country], numberOfPeoPle: [NumberOfPeople] = [.alone], category: [Category] = [.spicy], isAllRandom: Bool = true, favorite: Bool = false) {
        self.imageName = image
        self.name = name
        self.country = country
        self.numberOfPeoPle = numberOfPeoPle
        self.category = category
        self.isAllRandom = isAllRandom
        self.favorite = favorite
    }
}


    
    

var foods = [
    Food(image: ["samgyeopsal1", "samgyeopsal2", "samgyeopsal3"] ,name: "삼겹살", country: [.korean], numberOfPeoPle: [.couple, .family], category: [.meat], favorite: true),
    Food(image: ["Jajangmyeon1", "Jajangmyeon2", "Jajangmyeon3"], name: "짜장면", country: [.chinese], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle], favorite: true),
    Food(image: ["라멘1", "라멘2", "라멘3"], name: "라멘", country: [.japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle, .meat, .spicy, .soup], favorite: true),
    Food(image: ["돈까스1", "돈까스2", "돈까스3"] ,name: "돈까스", country: [.korean, .japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.meat, .friedFood]),
    Food(image: ["치즈돈까스1", "치즈돈까스2", "치즈돈까스3"], name: "치즈돈까스", country: [.korean, .japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.meat, .friedFood, .cheese]),
    Food(image: ["비빔밥1", "비빔밥2", "비빔밥3"], name: "비빔밥", country: [.korean], numberOfPeoPle: [.alone, .couple, .family], category: [.rice, .vegetable, .spicy]),
    Food(image: ["냉면1", "냉면2", "냉면3"], name: "냉면", country: [.korean], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle, .soup]),
    Food(image: ["짬뽕1", "짬뽕2", "짬뽕3"], name: "짬뽕", country: [.chinese], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle, .soup, .spicy]),
    Food(image: ["탕수육1", "탕수육2", "탕수육3"], name: "탕수육", country: [.chinese], numberOfPeoPle: [.alone, .couple, .family], category: [.meat, .friedFood]),
    Food(image: ["회1", "회2", "회3"], name: "회", country: [.none], numberOfPeoPle: [.alone, .couple, .family], category: [.seafood]),
    Food(image: ["텐동1", "텐동2", "텐동3"], name: "텐동", country: [.japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.rice, .friedFood]),
    Food(image: ["초밥1", "초밥2", "초밥3"], name: "초밥", country: [.japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.seafood, .rice]),
    Food(image: ["쭈꾸미볶음1", "쭈꾸미볶음2"], name: "쭈꾸미볶음", country: [.korean], numberOfPeoPle: [.alone, .couple, .family], category: [.seafood, .spicy, .rice])
]
