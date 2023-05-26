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
    var foodRecommendationList: FoodRecommendationList = FoodRecommendationList(imgae: UIImage(systemName: "questionmark")!, name: "2", description: "1", foodList: [])

    lazy var completeButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "완료")
        btn.action = #selector(save)
        return btn
    }()

    lazy var actions : [UIAction] = {
        return [
            UIAction(title: "편집", image: UIImage(systemName: "pencil")) { [self] _ in
                self.editeMode = true
                editTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                editTableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
                editTableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
                navigationItem.rightBarButtonItem = completeButton
            },
            UIAction(title: "삭제", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            }]
    }()

    lazy var menu: UIMenu = {
        return UIMenu(title: "", children: actions)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        entitysChangeToInstance()
        foods.forEach {
            $0.isChecked = false
        }
        if editeMode {
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "ellipsis"),  menu: menu)
        }
        NotificationCenter.default.addObserver(forName: .select, object: nil, queue: .main) { Notification in
            print("send")
            if let listInfo = Notification.userInfo?["name"] as? [Food] {
                self.list.append(contentsOf: listInfo)
                self.editTableView.reloadSections([1], with: .automatic)
                dump(self.list)
            }
        }
    }

    func settingNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료")
    }

    @objc func save() {
        print("asdasd-------------------")
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
        }

        NotificationCenter.default.post(name: .list, object: nil)

        self.presentingViewController?.dismiss(animated: true)
    }

    @IBAction func cancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }

    @IBAction func completeButtonTapped(_ sender: Any) {
        print("asdasd-------------------")
        //  1      foodRecommendationList.foodList = list
        
        // MARK: 이름 저장
        if let cell = editTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? FoodRecommendationListMainTableViewCell {
            print("1")
            guard let name = cell.titleField.text, name != "" else { return }
            if let foodRecommendationEntity {
                foodRecommendationEntity.name = name
                print("2")
            }
            // 1           foodRecommendationList.name = name
            self.name = name
        }
        // MARK: 설명 저장
        if let cell = editTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? FoodRecommendationListDescriptionTableViewCell {
            print("3")
            guard let description = cell.descriptionField.text else { return }
            if let foodRecommendationEntity {
                foodRecommendationEntity.listDescription = description
                print("3")
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

        if let foodRecommendationEntity {
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return list.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: 저장된 이름과 설명 텍스트 필드에 띄우기
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecommendationListMainTableViewCell", for: indexPath) as! FoodRecommendationListMainTableViewCell
                // MARK: 이름과 설명의 텍스트가 초기화 되는 현상을 방지하기 위해서 새로만드는게 아닌 만들어놨던걸로 전달하는 경우에만 텍스트 초기화
                if editeMode {
                    cell.titleField.isEnabled = true
                } else {
                    cell.titleField.isEnabled = false
                }
                if let target = foodRecommendationEntity, let set = target.foods as? Set<FoodEntity> {
                    let array = set.sorted { $0.name ?? "" > $1.name ?? ""}

                    cell.mainImageView.image = UIImage(named: array.first?.imageName?.components(separatedBy: ", ").first ?? "고기")
                }
                cell.titleField.text = foodRecommendationEntity?.name
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecommendationListDescriptionTableViewCell", for: indexPath) as! FoodRecommendationListDescriptionTableViewCell
                if editeMode {
                    cell.descriptionField.isEnabled = true
                } else {
                    cell.descriptionField.isEnabled = false
                }
                cell.descriptionField.text = foodRecommendationEntity?.listDescription
                return cell
            } else {
                //#MARK: 편집 모드일때만 음식추가 버튼 보이기
                if editeMode {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecommendationListAddTableViewCell", for: indexPath)
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DummyCell", for: indexPath)
                    return cell
                }
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecommendationListFoodTableViewCell", for: indexPath) as! FoodRecommendationListFoodTableViewCell
            if false {
                let set = foodRecommendationEntity?.foods as! Set<FoodEntity>
                
                let target = Array(set)[indexPath.row]

                
                if let imageName = target.imageName?.components(separatedBy: ", ").randomElement() {
                    cell.foodImageView.image = UIImage(named: imageName)!
                }
                
                cell.foodNameLabel.text = target.name
                
                return cell
            } else {
                let target = list[indexPath.row ]
                print(#function, list.count)
                
                if let imageName = target.imageName.randomElement() {
                    cell.foodImageView.image = UIImage(named: imageName)!
                }
                
                cell.foodNameLabel.text = target.name
                
                return cell
            }
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if editeMode && indexPath.section == 1 {
            return true
        } else {
             return false
        }
    }
}
