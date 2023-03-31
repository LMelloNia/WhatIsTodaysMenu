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
    var target: Food?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: .list, object: nil, queue: .main) { Notification in
            if let foodList = Notification.userInfo?["name"] as? FoodList {
                self.foodListList.append(foodList)
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
        let id = UUID().uuidString
//        NotificationCenter.default.addObserver(forName: .toThirdMainView, object: nil, queue: .main) { Notification in
//            if let l = Notification.userInfo?["name"] as? [Food] {
//                self.list = l
//                self.tableView.reloadData()
//            }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellToFoodList" {
            if let cell = sender as? FoodListFirstTableViewCell {
                if let indexPath = tableView.indexPath(for: cell) {
                    if let vc = segue.destination as? MakeFoodListViewController {
                        vc.editeMode = true
                        vc.foodList = foodListList[indexPath.row]
                        vc.list = foodListList[indexPath.row].foodList
                    }
                }
            }
        } else {
            if let vc = segue.destination as? MakeFoodListViewController {
                vc.editeMode = false
            }
        }
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
