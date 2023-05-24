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
                        vc.foodRecommendationEntity = CoreDataManager.shared.foodRecommendationEntityList[indexPath.row]
                    }
                }
            }
        } else {
            if let vc = segue.destination.children.first as? MakeFoodRecommendationListTableViewController {
                vc.editeMode = true
            }
        }
    }
}



extension FoodListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.foodRecommendationEntityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListFirstTableViewCell", for: indexPath) as! FoodListFirstTableViewCell
        cell.contentView.backgroundColor = view.backgroundColor
        if !CoreDataManager.shared.foodRecommendationEntityList.isEmpty {
            let target = CoreDataManager.shared.foodRecommendationEntityList[indexPath.row]
            if let set = target.foods as? Set<FoodEntity> {
                let array = set.sorted { $0.name ?? "" > $1.name ?? ""}

                cell.foodListImageView.image = UIImage(named: array.first?.imageName?.components(separatedBy: ", ").first ?? "고기")
            }
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



extension FoodListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.isSelected = false
        }
    }
}
