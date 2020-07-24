//
//  ToDoViewController.swift
//  20200710_1st
//
//  Created by Dustin on 2020/07/19.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import RealmSwift
import IQKeyboardManagerSwift



class ToDoViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    var toDoList : Results<toDo>!
    var cateID : Int?
    var detailVC = DetailViewViewController()
    let color = UIColor()
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Detail"
        IQKeyboardManager.shared.toolbarTintColor = color.textMain
        textField.becomeFirstResponder()
        
    }
    
    func configureTextField() {
        textField.delegate = self
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       
        dismiss(animated: true) {
            self.saveToDo(cateID: self.cateID!, id: self.createTodoNewID(), name: self.textField.text ?? "새 할일")
                NotificationCenter.default.post(name: NSNotification.Name("refreshData"), object: nil)
         
                   
        }
    }

}

extension ToDoViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
           return true
        }
    
    
}
