//
//  FoodSelectViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/10.
//

import UIKit

class FoodSelectViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let chechImage = UIImage(systemName: "checkmark.circle.fill")!
    let plusImage = UIImage(systemName: "plus.circle.fill")!
    
    var list = [Food]()
    var filteredFoods = foods
    var alreadyHaveFoods = [Food]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foods.forEach {
            $0.isChecked = false
        }
    }
    
    
    
    @IBAction func completeButtonTapped(_ sender: Any) {
//        if let indexPath = tableView.indexPathsForSelectedRows {
//            indexPath.forEach {
//                list.append(filteredFoods[$0.row])
//            }
//        }
        filteredFoods.forEach {
            if $0.isChecked {
                list.append($0)
            }
        }
        NotificationCenter.default.post(name: .select, object: nil, userInfo: ["name": list])
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    func actionSheet() {
        let alertController = UIAlertController(title: nil, message: "이 음식은 이미 추가되어 있습니다.", preferredStyle: .alert)
        
        let addAgain = UIAlertAction(title: "다시 추가", style: .default)
        
        let skip = UIAlertAction(title: "건너뛰기", style: .default) { _ in return }
        
        alertController.addAction(addAgain)
        alertController.addAction(skip)
        
        present(alertController, animated: true)
    }
}



extension FoodSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdViewTableViewCell")! as! ThirdViewTableViewCell
    
        if !filteredFoods.isEmpty {
            let target = filteredFoods[indexPath.row]
            
            if let imageName = target.imageName.first {
                cell.foodImageView.image = UIImage(named: imageName)!
            }
//            cell.foodImageView.image = target.imageName.first
            
//            if list.contains(where: { Food in
//                Food.name == filteredFoods[indexPath.row].name
//            })
            cell.foodNameLabel.text = target.name
            if target.isChecked {
//                cell.foodNameLabel.text = "\(target.name) 선택됨"
                cell.foodSelectButton.setImage(chechImage, for: .highlighted)
            } else {
                
                cell.foodSelectButton.setImage(plusImage, for: .highlighted)
            }
            // MARK: 둘중 하나는 수정
//            cell.foodCategoryLabel.text = target.returnCategoryList()
            cell.foodCategoryLabel.text = target.categoryList
        }
        
        return cell
    }
}



extension FoodSelectViewController: UISearchBarDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        list.append(filteredFoods[indexPath.row])
        let target = filteredFoods[indexPath.row]
        
        if let a = alreadyHaveFoods.first { food in
            food.name == target.name
        } {
            actionSheet()
            target.isChecked = true
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            target.isChecked.toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        
    }
    
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
