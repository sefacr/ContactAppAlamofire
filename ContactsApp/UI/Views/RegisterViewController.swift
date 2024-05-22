//
//  RegisterViewController.swift
//  ContactsApp
//
//  Created by Sefa Acar on 7.05.2024.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
       
    }
    
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        if let phoneNumber = phoneNumberTextField.text, let name = nameTextField.text {
            viewModel.save(name: name, phoneNumber: phoneNumber)
        }
    }
    
}
