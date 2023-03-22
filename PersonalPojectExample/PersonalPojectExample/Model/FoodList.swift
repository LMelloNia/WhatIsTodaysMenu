//
//  Data.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/08.
//

import Foundation
import UIKit

class FoodList {
    var imgae: UIImage // 이미지의 url
    var name: String
    var description: String
    var foodList: [Food]
    
    init(imgae: UIImage, name: String, description: String, foodList: [Food]) {
        self.imgae = imgae
        self.name = name
        self.description = description
        self.foodList = foodList
    }
}

