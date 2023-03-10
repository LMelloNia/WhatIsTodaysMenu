//
//  ViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/02.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cutomCell") as! CustomTableViewCell
        
        let target = foodList[indexPath.row]
        
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
