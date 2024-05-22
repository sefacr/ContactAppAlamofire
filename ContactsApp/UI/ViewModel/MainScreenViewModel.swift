//
//  MainScreenViewModel.swift
//  ContactsApp
//
//  Created by Sefa Acar on 14.05.2024.
//

import Foundation
import RxSwift

class MainScreenViewModel {
    
    var krepo = KisilerDaoRepository()
    var contactsList = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    
    init(){
        contactsList = krepo.contactsList
    }
    
    func search(searchText: String){
        krepo.search(searchText: searchText)
    }
    
    func delete(personId:Int) {
        krepo.delete(personId: personId)
        uploadContacts()
    }
    
    func uploadContacts(){
        krepo.uploadContacts()
    }
}
