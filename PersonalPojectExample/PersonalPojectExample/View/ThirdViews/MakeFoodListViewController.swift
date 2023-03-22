//
//  MakeFoodListViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/10.
//

import UIKit

extension Notification.Name {
    static let select = Notification.Name("FoodList")
}

class MakeFoodListViewController: UIViewController {

    @IBOutlet weak var tavleView: UITableView!
    var list: [Food]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: .select, object: nil, queue: .main) { Notification in
            if let l = Notification.userInfo?["name"] as? [Food] {
                self.list = l
                self.tavleView.reloadData()
            }
        }
    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
}



extension MakeFoodListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            return 1
        } else {
            if let l = list {
                return l.count
            } else {
                return 0
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListMainTableViewCell", for: indexPath) as! FoodListMainTableViewCell
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListCreatButtonTableViewCell", for: indexPath) as! FoodListCreatButtonTableViewCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListContentsTableViewCell", for: indexPath) as! FoodListContentsTableViewCell
            
            if let l = list {
                let target = l[indexPath.row]
                cell.foodImageView.image = target.image.first
                cell.foodNameLabel.text = target.name
            }
            return cell
        }
    }
}
