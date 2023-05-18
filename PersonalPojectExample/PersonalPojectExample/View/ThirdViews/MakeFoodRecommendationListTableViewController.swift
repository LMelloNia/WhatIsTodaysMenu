//
//  MakeFoodRecommendationListTableViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/04/11.
//

import UIKit

extension Notification.Name {
    static let select = Notification.Name("FoodList")
    static let listName = Notification.Name("listName")
}

class MakeFoodRecommendationListTableViewController: UITableViewController {
    
    @IBOutlet var editTableView: UITableView!
    
    var list = [Food]()
    
    var entityList = [FoodEntity]()
    
    var editeMode: Bool = false
    
    var name: String = ""
    
    var listDescription: String = ""
    
    var foodRecommendationEntity: FoodRecommendationListEntity?
    
    var foodRecommendationList: FoodRecommendationList = FoodRecommendationList(imgae: UIImage(named: "라멘1")!, name: "2", description: "1", foodList: [])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entitysChangeToInstance()
        foods.forEach {
            $0.isChecked = false
        }
        
        NotificationCenter.default.addObserver(forName: .select, object: nil, queue: .main) { Notification in
            if let list = Notification.userInfo?["name"] as? [Food] {
                self.list.append(contentsOf: list)
                self.editTableView.reloadData()
                dump(self.list)
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    @IBAction func completeButtonTapped(_ sender: Any) {
//  1      foodRecommendationList.foodList = list
        
        // MARK: 이름 저장
        if let cell = editTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? FoodRecommendationListMainTableViewCell {
            guard let name = cell.titleField.text, name != "" else { return }
            if let foodRecommendationEntity {
                foodRecommendationEntity.name = name
            }
// 1           foodRecommendationList.name = name
            self.name = name
        }
        // MARK: 설명 저장
        if let cell = editTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? FoodRecommendationListDescriptionTableViewCell {
            guard let description = cell.descriptionField.text else { return }
            if let foodRecommendationEntity {
                foodRecommendationEntity.listDescription = description
            }
//  1          foodRecommendationList.description =  description
            self.listDescription = description
        }
        
        // MARK: 음식추천리스트 엔티티 생성
        list.forEach { Food in
            let foodEntity = CoreDataManager.shared.foodEntitys.first { FoodEntity in
                FoodEntity.name == Food.name
            }
            guard let foodEntity else { return }
            entityList.append(foodEntity)
        }

        if editeMode {
            guard let foodRecommendationEntity else { return }
            CoreDataManager.shared.updateFoodRecommendationList(name: name, description: listDescription, foods: entityList, foodRecommendationList: foodRecommendationEntity)
        } else {
            CoreDataManager.shared.createFoodRecommendationList(name: name, description: listDescription, foods: entityList)
        }

        
        NotificationCenter.default.post(name: .list, object: nil)
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    func entitysChangeToInstance() {
        guard let foodEntitys = foodRecommendationEntity?.foods as? Set<FoodEntity> else { return }
        
        foodEntitys.forEach { foodEntity in
            let food = foods.first { food in
                food.name == foodEntity.name
            }
            
            guard let food else { return }
            list.append(food)
        }
    }
    
    
    // MARK: 마지막 뷰에 이미 리스트에 있는 음식들을 넘겨주기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? FoodChooseViewController {
            guard !list.isEmpty else { return }
            vc.alreadyHaveFoods = list
        }
    }
    
    
    
    // MARK: 저장된 이름과 설명 텍스트 필드에 띄우기

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if false {
            if let count = foodRecommendationEntity?.foods?.count {
                return count + 3
            }
            return 3
        } else {
            return list.count + 3
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecommendationListMainTableViewCell", for: indexPath) as! FoodRecommendationListMainTableViewCell
            // MARK: 이름과 설명의 텍스트가 초기화 되는 현상을 방지하기 위해서 새로만드는게 아닌 만들어놨던걸로 전달하는 경우에만 텍스트 초기화
            if editeMode {
                cell.titleField.text = foodRecommendationEntity?.name
            }
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecommendationListDescriptionTableViewCell", for: indexPath) as! FoodRecommendationListDescriptionTableViewCell
            
            if editeMode {
                cell.descriptionField.text = foodRecommendationEntity?.listDescription
            }
            
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecommendationListAddTableViewCell", for: indexPath)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecommendationListFoodTableViewCell", for: indexPath) as! FoodRecommendationListFoodTableViewCell
            
            if false {
                let set = foodRecommendationEntity?.foods as! Set<FoodEntity>
                
                let target = Array(set)[indexPath.row - 3]
        
                
                if let imageName = target.imageName?.components(separatedBy: ", ").randomElement() {
                    cell.foodImageView.image = UIImage(named: imageName)!
                }
                
                cell.foodNameLabel.text = target.name
                
                return cell
            } else {
                let target = list[indexPath.row - 3]
                
                
                if let imageName = target.imageName.randomElement() {
                    cell.foodImageView.image = UIImage(named: imageName)!
                }
                
                cell.foodNameLabel.text = target.name
                
                return cell
            }
        }
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    //        override func numberOfSections(in tableView: UITableView) -> Int {
    //            // #warning Incomplete implementation, return the number of sections
    //            return 1
    //        }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
