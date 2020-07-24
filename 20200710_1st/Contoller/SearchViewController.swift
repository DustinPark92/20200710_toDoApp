//
//  SearchViewController.swift
//  20200710_1st
//
//  Created by Dustin on 2020/07/17.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()

    }
    
    func configureTextField() {
        textField.delegate = self
        textField.becomeFirstResponder()
    }
    
    func configureUI() {
        
    }
    
    @IBAction func handleCancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
}

extension SearchViewController : UITextFieldDelegate {
    
    
    
    
}
