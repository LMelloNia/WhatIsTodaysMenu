//
//  ViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/02.
//

import UIKit


class FoodViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}



extension FoodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cutomCell") as! CustomTableViewCell
        
        let target = foods[indexPath.row]
        
        cell.data = target
        
        cell.foodImageView.image = target.image.randomElement()
        cell.foodNameLabel.text = target.name
        cell.foodCategoryLabel.text = target.returnCategoryList()
        
        if target.isAllRandom { cell.isAllRandomButton.setTitle("❤️", for: .normal)
        } else {
            cell.isAllRandomButton.setTitle("💔", for: .normal)
        }
        
        return cell
    }
}



extension FoodViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.reloadData()
//    }
}
