//
//  RegisterViewModel.swift
//  ContactsApp
//
//  Created by Sefa Acar on 14.05.2024.
//

import Foundation


class RegisterViewModel {
    var krepo = KisilerDaoRepository()
    func save(name: String, phoneNumber: String){
        krepo.save(name: name, phoneNumber: phoneNumber)
    }
}
