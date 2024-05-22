//
//  ViewController.swift
//  ContactsApp
//
//  Created by Sefa Acar on 7.05.2024.
//

import UIKit
import RxSwift

class MainScreen: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var personsTableView: UITableView!
    
    var PersonList = [Kisiler]()
    var viewModel = MainScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        personsTableView.delegate = self
        personsTableView.dataSource = self
        
        _ = viewModel.contactsList.subscribe(onNext: { list in
            self.PersonList = list
            DispatchQueue.main.async {
                self.personsTableView.reloadData()
            }
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("anasayfaya dönüldü, sayfa ilk açıldığı an çalışır")
        viewModel.uploadContacts()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let person = sender as? Kisiler { //sender'i any'den Kisiler'e çevirdik super class sub class dönüşümünü sağlatık ??
                let destinationVC = segue.destination as! DetailViewController
                destinationVC.person = person
                
            }
        }
    }
    
}


extension MainScreen : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText: searchText)
    }
}

extension MainScreen : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell") as! PersonsTableViewCell
        
        let person = PersonList[indexPath.row]
        cell.nameLabel.text = person.kisi_ad
        cell.phoneNumberLabel.text = person.kisi_tel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = PersonList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: person)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            contextualAction, view, bool in
            let person = self.PersonList[indexPath.row]
            
            let alert = UIAlertController(title: "DELETE", message: "Are you sure you want to have '\(person.kisi_ad!)' ? ", preferredStyle: .alert)
            let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelBtn)
            let deleteBtn = UIAlertAction(title: "Delete Contact", style: .destructive) {
                action in
                self.viewModel.delete(personId: Int(person.kisi_id!)!)
            }
            alert.addAction(deleteBtn)
            
            self.present(alert, animated: true)
            
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}
