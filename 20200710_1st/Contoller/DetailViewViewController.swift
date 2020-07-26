//
//  DetailViewViewController.swift
//  20200710_1st
//
//  Created by Dustin on 2020/07/15.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewViewController: UIViewController {
    
//MARK: - Property
    let color = UIColor() //저장 프로퍼티 클래스 -> class에 저장.
    let img = UIImage()
    let ft = UIFont()
    
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var keyBoardInputView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var keyBoardInsideView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addBarLeftImg: UIImageView!
    @IBOutlet weak var addButtonLabel: UILabel!

    
    
    var fav : Favorite = .normal
    var list : Results<Category>!
    var toDoVC : ToDoViewController?
    let realm = try! Realm()

    var makeANewDiary = false
    var makeAFirstTodo = false
    var cateID = 0
    var data: Category!

    
    private lazy var textFieldTitle : UITextField = {
    let v = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
        v.text = ""
       return v
    }()
    
//MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNewDiary()
        configureTableView()
        configureUI()
        configureCV()
        NotificationCenter.default.addObserver(self, selector: #selector(receivedData(noti:)), name: NSNotification.Name("refreshData"), object: nil)
      
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


    }
    
//MARK: - Selectors
    
    @objc func receivedData(noti : NSNotification) {
        //내가 전송해했던 키네임 불러오기 , 타입 불러오기
        list = realm.objects(Category.self).filter("id = \(cateID)")
        if makeANewDiary {
            makeAFirstTodo = true
        }
        
        tableView.reloadData()
        
    }
//MARK: - Helpers
    @IBAction func handleTodo(_ sender: UIButton) {
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ToDoViewController") as! ToDoViewController
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        if makeANewDiary {
        vc.cateID = cateID
        } else {
        vc.cateID = data.id
        }

        present(vc, animated: true, completion: nil)
        
    }
    func setNewDiary() {
        if makeANewDiary {
           textField.becomeFirstResponder()
            keyBoardInputView.addSubview(keyBoardInsideView)
            textField.inputAccessoryView = keyBoardInputView
        } else {
       
            textField.text = data.name
        }
        
    }
    
    
    func configureUI() {
        navigationItem.titleView = textFieldTitle
        tableView.backgroundColor = color.bg
        addButtonLabel.textColor = color.textMain
        textFieldTitle.delegate = self
        textField.delegate = self
        
        
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        tableView.rowHeight = 88
        
        
    }
    
    func configureCV() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "KeyBoardInPutViewInCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "KeyBoardInPutViewInCollectionViewCell")
    }
    

}

//MARK: - UITableViewDelegate & DataSource
extension DetailViewViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !makeANewDiary {
        return data.todo.count
        } else if makeAFirstTodo {
            return data.todo.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
  
        let item = data.todo[indexPath.row]
        cell.detailLabel.text = item.name

        
       
        
        return cell
    
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return textFieldView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title:  "삭제", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in

            self.deleteTodo(toDoID: self.data.todo[indexPath.row].id)
                  self.tableView.reloadData()


                    success(true)

                })

            return UISwipeActionsConfiguration(actions:[deleteAction])

        }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        

        if scrollView.contentOffset.y < 0 {
            
            UIView.animate(withDuration: 0.5) {
                self.textFieldView.isHidden = false
                self.textFieldTitle.text = ""
            }
        } else if scrollView.contentOffset.y > 3 {
            UIView.animate(withDuration: 0.5) {
                self.textFieldView.isHidden = true
                if self.textField.text == "" {
                    self.textFieldTitle.text = "제목 없는 목록"
                } else {
                self.textFieldTitle.text = self.textField.text
                }
            }
        }
         
        }
    
    
    
}

//MARK: - UICollectionViewDelegate & DataSource

extension DetailViewViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyBoardInPutViewInCollectionViewCell", for: indexPath) as! KeyBoardInPutViewInCollectionViewCell
        
        cell.backgroundColor = .white
        
        
        return cell
    }
    
    
 
        
        
    }
//MARK: - UICollectionViewFlowLayOut

extension DetailViewViewController : UICollectionViewDelegateFlowLayout {
    

    
    
}


//MARK: - UITextFieldDelegate

extension DetailViewViewController : UITextFieldDelegate {
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        if makeANewDiary {
            editCate(name: textField.text ?? "제목 없는 목록", id: cateID)
        } else {
            editCate(name: textField.text ?? "제목 없는 목록", id: data.id)
        }
           textFieldTitle.resignFirstResponder()
           return true
        }
    
    
    
}


