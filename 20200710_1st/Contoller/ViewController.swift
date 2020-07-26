//
//  ViewController.swift
//  20200710_1st
//
//  Created by Dustin on 2020/07/10.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class ViewController: UIViewController {
    
    let color = UIColor() //저장 프로퍼티 클래스 -> class에 저장.
    let img = UIImage()
    let ft = UIFont()
    let realm = try! Realm()
    var list : Results<Category>!
    var cateSpecificList : Results<Category>!
    
    
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addBarRightImg: UIImageView!
    @IBOutlet weak var addBarLeftImg: UIImageView!
    @IBOutlet weak var addButtonLabel: UILabel!
    var cateID : Int?
    var cateData : Category!
    
    
     
    private let seperatorView : UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        configureTableView()
        configureUI()
        
        list = getCategoryALL()
        
    }
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        tableView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = false

        
    }
    
        

    
    //MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.backgroundColor = color.bg
        tableView.backgroundColor = color.bg
        addButtonLabel.textColor = color.textMain
        
        
    }
    
    func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        
        
    }
    
    @IBAction func handleWidgetData(_ sender: UIBarButtonItem) {
        
        let share = UserDefaults(suiteName: "group.Dustin.-0200710-1st")
        
        share!.set("병호", forKey: "todo")
        
        
    }
    @IBAction func handleAddButton(_ sender: UIButton) {
        
        let secondStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                   
        let vc = secondStoryBoard.instantiateViewController(withIdentifier: "DetailViewViewController") as! DetailViewViewController
        vc.makeANewDiary = true
        cateID = createCateNewID()
        guard let id = cateID else { return }
        
        
        saveCategory(id: id , name: "제목없는 목록")
        
        vc.cateID = id
        vc.data = list[id - 2]

        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func handleSearchBtn(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
        
        
        
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else if section == 1 {
            return 4
        }
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        switch indexPath.section {
        case 0:
            cell.categoryLabel.text = "즐찾 목록"
        case 1:
            cell.categoryLabel.text = "즐찾 할일"
        case 2:
            let item = list[indexPath.row]
            cell.categoryLabel.text = item.name
            cell.countLabel.text = "\(item.todo.count)"
        default:
            break;
        }
        
       
        
         
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "⭐즐찾 목록"
        } else if section == 1 {
            return "⭐즐찾 할일"
        }
        return "🗒목록"
    }
    
   
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let secondStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                   
        let vc = secondStoryBoard.instantiateViewController(withIdentifier: "DetailViewViewController") as! DetailViewViewController
        
        switch indexPath.section {
        case 0:
        vc.data = list[indexPath.row]
        case 1:
        vc.data = list[indexPath.row]
        case 2:
        vc.data = list[indexPath.row]
  
        default:
            break;
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title:  "삭제", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in

            self.deleteCategory(cateID: self.list[indexPath.row].id)
            self.tableView.reloadData()

                    success(true)

                })

            return UISwipeActionsConfiguration(actions:[deleteAction])

        }




    
}


