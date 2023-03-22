//
//  FoodSelectViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/10.
//

import UIKit

class FoodSelectViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var list: [Food] = []
    var filteredFoods = foods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        if let indexPath = tableView.indexPathsForSelectedRows {
            indexPath.forEach {
                list.append(filteredFoods[$0.row])
            }
        }
        
        NotificationCenter.default.post(name: .select, object: nil, userInfo: ["name": list])
        
        self.presentingViewController?.dismiss(animated: true)
    }
}



extension FoodSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodSelect")! as! ThirdViewTableViewCell
        
        if !filteredFoods.isEmpty {
            print(filteredFoods.count, "🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍🤍❤️")
            let target = filteredFoods[indexPath.row]
            
            cell.foodImageView.image = target.image.first
            cell.foodNameLabel.text = target.name
            cell.foodCategoryLabel.text = target.returnCategoryList()
        }
        
        return cell
    }
}



extension FoodSelectViewController: UISearchBarDelegate {
    func filter(with keyword: String) {
        if keyword.count > 0 {
            filteredFoods = foods.filter { $0.name.contains(keyword) }
        } else {
            filteredFoods = foods
        }
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter(with: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
    }
}



extension FoodSelectViewController: UITableViewDelegate {
    
}
// MARK: 질문 리스트
// MARK: 멀티선택에서 선택을 해제하면 리스트에 추가하지 않기
// MARK: 검색한 후에 선택하게 되면 선택이 유지되지 않음, 유지되게 할수있는 방법
