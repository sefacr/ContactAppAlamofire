//
//  DetailViewController.swift
//  ContactsApp
//
//  Created by Sefa Acar on 7.05.2024.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var person: Kisiler?
    var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let k = person {
            nameTextField.text = k.kisi_ad
            phoneNumberTextField.text = k.kisi_tel
        }
       
    }
    
    @IBAction func updateBtnClicked(_ sender: Any) {
        if let name = nameTextField.text, let phoneNumber = phoneNumberTextField.text, let k = person {
            viewModel.update(kisi_id: Int(k.kisi_id!)!, kisi_ad: name, kisi_tel: phoneNumber)
        }
    }
    
}
