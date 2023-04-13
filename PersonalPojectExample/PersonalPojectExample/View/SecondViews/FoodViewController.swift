//
//  ViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/02.
//

import UIKit
// MARK: 음식목록을 띄워주는 뷰
class FoodViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}



extension FoodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return foods.count
        return CoreDataManager.shared.foodEntitys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cutomCell") as! CustomTableViewCell
        
//        let target = foods[indexPath.row]
        let target = CoreDataManager.shared.foodEntitys[indexPath.row]
        
//        cell.data = target
        cell.foodEntity = target
        cell.isAllRandom = target.isAllRandom
//        if let imageName = target.imageName.randomElement() {
//            cell.foodImageView.image = UIImage(named: imageName)!
//        }
        if let imageName = target.imageName?.components(separatedBy: ", ").randomElement() {
            cell.foodImageView.image = UIImage(named: imageName)!
        }
        
        cell.foodNameLabel.text = target.name
        
        // MARK: 둘중 하나는 수정
        cell.foodCategoryLabel.text = target.categories
//        cell.foodCategoryLabel.text = target.returnCategoryList()
        
        if target.isAllRandom { cell.isAllRandomButton.setTitle("❤️", for: .normal)
        } else {
            cell.isAllRandomButton.setTitle("💔", for: .normal)
        }
        
        return cell
    }
}
