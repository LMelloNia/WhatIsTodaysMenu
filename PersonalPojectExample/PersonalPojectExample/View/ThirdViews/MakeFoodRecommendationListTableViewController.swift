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
//    static let toThirdMainView = Notification.Name("toThirdMainView")
}

class MakeFoodRecommendationListTableViewController: UITableViewController {
    
    @IBOutlet var editTableView: UITableView!
    
    var list: [Food] = []
    var editeMode: Bool = false
    var foodList: FoodList = FoodList(imgae: UIImage(named: "라멘1")!, name: "", description: "", foodList: [])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foods.forEach {
            $0.isChecked = false
        }
        NotificationCenter.default.addObserver(forName: .select, object: nil, queue: .main) { Notification in
            if let list = Notification.userInfo?["name"] as? [Food] {
                self.list = list
                self.editTableView.reloadData()
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
        
            print(#function, "1")
    }
    
    
    @IBAction func createButtonTapped(_ sender: Any) {
        foodList.foodList = list
        
        // MARK: 이름 저장
        if let cell = editTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? FoodRecommendationListMainTableViewCell {
            foodList.name = cell.titleField.text ?? "이름 저장 안됨"
        }
        // MARK: 설명 저장
        if let cell = editTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? FoodRecommendationListDescriptionTableViewCell {
            foodList.description = cell.descriptionField.text ?? "설명 저장 안됨"
        }
        NotificationCenter.default.post(name: .list, object: nil, userInfo: ["name": foodList])
        self.presentingViewController?.dismiss(animated: true)
    }
    // MARK: 저장된 이름과 설명 텍스트 필드에 띄우기

    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count + 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecommendationListMainTableViewCell", for: indexPath) as! FoodRecommendationListMainTableViewCell
            cell.titleField.text = foodList.name
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecommendationListDescriptionTableViewCell", for: indexPath) as! FoodRecommendationListDescriptionTableViewCell
            cell.descriptionField.text = foodList.description
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecommendationListAddTableViewCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecommendationListFoodTableViewCell", for: indexPath) as! FoodRecommendationListFoodTableViewCell
            
            let target = list[indexPath.row - 3]
            if let imageName = target.imageName.randomElement() {
//                cell.foodImageView.image = target.imageName.first
                cell.foodImageView.image = UIImage(named: imageName)!
            }
            
            cell.foodNameLabel.text = target.name
            
            return cell
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
