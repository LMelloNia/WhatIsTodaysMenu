//
//  FoodSelectViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/10.
//

import UIKit

class FoodSelectViewController: UIViewController {

    var list: [Food]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
        
    }
}



extension FoodSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodSelect")! as! ThirdViewTableViewCell
        
        let target = foods[indexPath.row]
        
        cell.foodImageView.image = target.image.randomElement()
        cell.foodNameLabel.text = target.name
        cell.foodCategoryLabel.text = target.returnCategoryList()
        
        return cell
    }
}

extension FoodSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list?.append(foods[indexPath.row])
    }
}
