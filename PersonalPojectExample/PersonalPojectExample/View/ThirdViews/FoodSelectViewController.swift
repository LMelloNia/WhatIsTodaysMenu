//
//  FoodSelectViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/10.
//

import UIKit

class FoodSelectViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var list: [Food]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = []
    }
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        if let indexPath = tableView.indexPathsForSelectedRows {
            indexPath.map {
                list?.append(foods[$0.row])
            }
        }
        NotificationCenter.default.post(name: .select, object: nil, userInfo: ["name": list])
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


// -MARK: 멀티선택에서 선택을 해제하면 리스트에 추가하지 않기
extension FoodSelectViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        list?.append(foods[indexPath.row])
//    }
    
    
    
}
