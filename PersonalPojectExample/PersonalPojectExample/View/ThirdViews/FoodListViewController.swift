//
//  FoodListViewController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/10.
//

import UIKit

extension Notification.Name {
    static let list = Notification.Name("FoodList")
}

class FoodListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var list = [Food]()
    var foodRecommendationListList: [FoodRecommendationList] = []
    var target: Food?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.shared.fetchFoodRecommendationList()
        NotificationCenter.default.addObserver(forName: .list, object: nil, queue: .main) { Notification in
                CoreDataManager.shared.fetchFoodRecommendationList()
                self.tableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard !CoreDataManager.shared.foodRecommendationEntityList.isEmpty else { return }
        if segue.identifier == "cellToFoodList" {
            if let cell = sender as? FoodListFirstTableViewCell {
                if let indexPath = tableView.indexPath(for: cell) {
                    if let vc = segue.destination.children.first as? MakeFoodRecommendationListTableViewController {
                        vc.editeMode = true
                        vc.foodRecommendationEntity = CoreDataManager.shared.foodRecommendationEntityList[indexPath.row]
                    }
                }
            }
        } else {
            if let vc = segue.destination.children.first as? MakeFoodRecommendationListTableViewController {
                vc.editeMode = false
            }
        }
    }
}



extension FoodListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CoreDataManager.shared.foodRecommendationEntityList.count > 1 {
            return CoreDataManager.shared.foodRecommendationEntityList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListFirstTableViewCell", for: indexPath) as! FoodListFirstTableViewCell
        if !CoreDataManager.shared.foodRecommendationEntityList.isEmpty {
            let target = CoreDataManager.shared.foodRecommendationEntityList[indexPath.row]
//            cell.foodListImageView.image = target.imgae
            cell.foodListNameLabel.text = target.name
            cell.foodListDescriptionLabel.text = target.listDescription
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        CoreDataManager.shared.removeFoodRecommendationList(target: CoreDataManager.shared.foodRecommendationEntityList[indexPath.row])
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
