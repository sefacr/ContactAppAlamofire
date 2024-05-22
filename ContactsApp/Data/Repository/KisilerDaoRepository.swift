//
//  KisilerDaoRepository.swift
//  ContactsApp
//
//  Created by Sefa Acar on 14.05.2024.
//

import Foundation
import RxSwift


class KisilerDaoRepository {
    
    var contactsList = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    //http://kasimadalan.pe.hu/kisiler/tum_kisiler.php
    
    func save(name: String, phoneNumber: String){
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php")!)
        request.httpMethod = "POST"
        let postString = "kisi_ad=\(name)&kisi_tel=\(phoneNumber)"
        request.httpBody = postString.data(using: .utf8)
        
         URLSession.shared.dataTask(with: request) {data, response, error in
             do{
                 let reply = try JSONDecoder().decode(CRUDResponse.self, from: data!)
                 print("---------Insert-------")
                 print("Başarı : \(reply.success!)")
                 print("Mesaj : \(reply.message!)")
             }catch{
                 print(error.localizedDescription)
             }
         }.resume()
         
    }
    
    func update(kisi_id: Int, kisi_ad: String, kisi_tel: String){
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/update_kisiler.php")!)
        request.httpMethod = "POST"
        let postString = "kisi_id=\(kisi_id)&kisi_ad=\(kisi_ad)&kisi_tel=\(kisi_tel)"
        request.httpBody = postString.data(using: .utf8)
        
         URLSession.shared.dataTask(with: request) {data, response, error in
             do{
                 let reply = try JSONDecoder().decode(CRUDResponse.self, from: data!)
                 print("---------Update-------")
                 print("Başarı : \(reply.success!)")
                 print("Mesaj : \(reply.message!)")
             }catch{
                 print(error.localizedDescription)
             }
         }.resume()
    }
    
    func search(searchText: String){
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php")!)
        request.httpMethod = "POST"
        let postString = "kisi_ad=\(searchText)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) {data, response, error in
            do{
                let reply = try JSONDecoder().decode(KisilerResponse.self, from: data!)
                if let list = reply.kisiler {
                    self.contactsList.onNext(list)
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func delete(personId:Int) {
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/delete_kisiler.php")!)
        request.httpMethod = "POST"
        let postString = "kisi_id=\(personId)"
        request.httpBody = postString.data(using: .utf8)
        
         URLSession.shared.dataTask(with: request) {data, response, error in
             do{
                 let reply = try JSONDecoder().decode(CRUDResponse.self, from: data!)
                 print("---------Delete-------")
                 print("Başarı : \(reply.success!)")
                 print("Mesaj : \(reply.message!)")
             }catch{
                 print(error.localizedDescription)
             }
         }.resume()
    }
    
    func uploadContacts(){
       let url = URL(string: "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php")!
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            do{
                let reply = try JSONDecoder().decode(KisilerResponse.self, from: data!)
                if let list = reply.kisiler {
                    self.contactsList.onNext(list)
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
        
    }
}
