//
//  FoodListViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/10.
//

import UIKit

extension Notification.Name {
    static let list = Notification.Name("FoodList")
}



class FoodListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var list = [Food]()
    var foodListList: [FoodList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: .list, object: nil, queue: .main) { Notification in
            if let foodList = Notification.userInfo?["name"] as? FoodList {
                self.foodListList.append(foodList)
                
                self.tableView.reloadData()
            }
        }
//        NotificationCenter.default.addObserver(forName: .toThirdMainView, object: nil, queue: .main) { Notification in
//            if let l = Notification.userInfo?["name"] as? [Food] {
//                self.list = l
//                self.tableView.reloadData()
//            }
//        }
        tableView.reloadData()
    }
}



extension FoodListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if foodListList.count == 0 {
            return 1
        } else {
            return foodListList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListFirstTableViewCell", for: indexPath) as! FoodListFirstTableViewCell
        
        if !foodListList.isEmpty {
            let target = foodListList[indexPath.row]
            cell.foodListImageView.image = target.imgae
            cell.foodListNameLabel.text = target.name
            cell.foodListDescriptionLabel.text = target.description
        }
        
        return cell
    }
}
