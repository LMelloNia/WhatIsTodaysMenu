//
//  MakeFoodListViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/10.
//

import UIKit

class MakeFoodListViewController: UIViewController {

    var list: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
}



extension MakeFoodListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            return 1
        } else {
            return list.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListMainTableViewCell", for: indexPath) as! FoodListMainTableViewCell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListCreatButtonTableViewCell", for: indexPath) as! FoodListCreatButtonTableViewCell
        } else {
            
        }
        
        
        return cell
    }
}
