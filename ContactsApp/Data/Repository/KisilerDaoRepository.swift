//
//  KisilerDaoRepository.swift
//  ContactsApp
//
//  Created by Sefa Acar on 14.05.2024.
//

import Foundation
import RxSwift
import Alamofire


class KisilerDaoRepository {
    
    var contactsList = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    //http://kasimadalan.pe.hu/kisiler/tum_kisiler.php
    
    func save(name: String, phoneNumber: String){
        let params: Parameters = ["kisi_ad":name,"kisi_tel":phoneNumber]
        AF.request("http://kasimadalan.pe.hu/kisiler/insert_kisiler.php", method: .post, parameters: params).response { response in
            if let data = response.data{
                do{
                    let reply = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("----------INSERT---------")
                    print("Başarı : \(reply.success!)")
                    print("Mesaj : \(reply.message!)")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func update(kisi_id: Int, kisi_ad: String, kisi_tel: String){
        let params: Parameters = ["kisi_id":kisi_id, "kisi_ad": kisi_ad, "kisi_tel": kisi_tel]
        AF.request("http://kasimadalan.pe.hu/kisiler/update_kisiler.php", method: .post, parameters: params).response { response in
            if let data = response.data{
                do{
                    let reply = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("----------UPDATE---------")
                    print("Başarı : \(reply.success!)")
                    print("Mesaj : \(reply.message!)")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func search(searchText: String){
        let params: Parameters = ["kisi_ad": searchText]
        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php", method: .post, parameters: params).response { response in
            if let data = response.data{
                do{
                    let reply = try JSONDecoder().decode(KisilerResponse.self, from: data)
                    if let list = reply.kisiler {
                        self.contactsList.onNext(list)
                    }
                }catch{
                    print(error.localizedDescription)
                    let list = [Kisiler]()
                    self.contactsList.onNext(list)
                }
            }
        }
    }
    
    func delete(personId:Int) {
        let params: Parameters = ["kisi_id":personId]
        AF.request("http://kasimadalan.pe.hu/kisiler/delete_kisiler.php", method: .post, parameters: params).response { response in
            if let data = response.data{
                do{
                    let reply = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("----------DELETE---------")
                    print("Başarı : \(reply.success!)")
                    print("Mesaj : \(reply.message!)")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    func uploadContacts(){
        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler.php", method: .get).response { response in
            if let data = response.data{
                do{
                    let reply = try JSONDecoder().decode(KisilerResponse.self, from: data)
                    if let list = reply.kisiler {
                        self.contactsList.onNext(list)
                    }
                    let rawResponse = try JSONSerialization.jsonObject(with: data) //webservisten gelen ham data
                    print(rawResponse)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
