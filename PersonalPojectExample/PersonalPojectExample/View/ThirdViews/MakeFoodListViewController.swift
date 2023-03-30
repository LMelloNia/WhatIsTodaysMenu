//
//  MakeFoodListViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/10.
//

import UIKit

extension Notification.Name {
    static let select = Notification.Name("FoodList")
    static let listName = Notification.Name("listName")
}



class MakeFoodListViewController: UIViewController {
    
    @IBOutlet weak var tavleView: UITableView!
    
    var list: [Food] = []
    let foodList: FoodList = FoodList(imgae: UIImage(named: "라멘1")!, name: "목록이름입니다", description: "설명입니다", foodList: [])
    
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
        foodList.foodList = list
        let cell = tavleView.visibleCells.first as? FoodListMainTableViewCell
        foodList.name = cell?.listNameTextField.text ?? "이름"
        
        NotificationCenter.default.post(name: .list, object: nil, userInfo: ["name": foodList])
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
            return list.count
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
            
            let target = list[indexPath.row]
            cell.foodImageView.image = target.image.first
            cell.foodNameLabel.text = target.name
            
            return cell
        }
    }
    
}
// MARK: 질문 목록
// MARK: 목록이름 텍스트필드의 텍스트가 바뀌었을때 이름으로 저장하기 - 테이블뷰가 있는 뷰컨트롤러에서 해당 테이블뷰의 커스텀셀의 텍스트필드의 문자에 접근하는 방법
