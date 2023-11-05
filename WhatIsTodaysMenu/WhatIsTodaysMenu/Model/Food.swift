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
    Food(image: ["samgyeopsal1", "samgyeopsal2", "samgyeopsal3"]
         , name: "삼겹살", country: [.korean], numberOfPeoPle: [.couple, .family], category: [.meat], favorite: true),
    Food(image: ["jajangmyeon1", "jajangmyeon2", "jajangmyeon3"],
         name: "짜장면", country: [.chinese], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle], favorite: true),
    Food(image: ["ramen1", "ramen2", "ramen3"],
         name: "라멘", country: [.japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle, .meat, .spicy, .soup], favorite: true),
    Food(image: ["tonkatsu1", "tonkatsu2", "tonkatsu3"]
         , name: "돈까스", country: [.korean, .japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.meat, .friedFood]),
    Food(image: ["cheesetonkatsu1", "cheesetonkatsu2", "cheesetonkatsu3"],
         name: "치즈돈까스", country: [.korean, .japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.meat, .friedFood, .cheese]),
    Food(image: ["bibimbap1", "bibimbap2", "bibimbap3"],
         name: "비빔밥", country: [.korean], numberOfPeoPle: [.alone, .couple, .family], category: [.rice, .vegetable, .spicy]),
    Food(image: ["naengmyeon1", "naengmyeon2", "naengmyeon3"],
         name: "냉면", country: [.korean], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle, .soup]),
    Food(image: ["jjamppong1", "jjamppong2", "jjamppong3"],
         name: "짬뽕", country: [.chinese], numberOfPeoPle: [.alone, .couple, .family], category: [.noodle, .soup, .spicy]),
    Food(image: ["tangsuyuk1", "tangsuyuk2", "tangsuyuk3"],
         name: "탕수육", country: [.chinese], numberOfPeoPle: [.alone, .couple, .family], category: [.meat, .friedFood]),
    Food(image: ["sashimi1", "sashimi2", "sashimi3"],
         name: "회", country: [.none], numberOfPeoPle: [.alone, .couple, .family], category: [.seafood]),
    Food(image: ["tendon1", "tendon2", "tendon3"],
         name: "텐동", country: [.japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.rice, .friedFood]),
    Food(image: ["sushi1", "sushi2", "sushi3"],
         name: "초밥", country: [.japanese], numberOfPeoPle: [.alone, .couple, .family], category: [.seafood, .rice]),
    Food(image: ["jukkumibokkeum1", "jukkumibokkeum2"],
         name: "쭈꾸미 볶음", country: [.korean], numberOfPeoPle: [.alone, .couple, .family], category: [.seafood, .spicy, .rice])
]
