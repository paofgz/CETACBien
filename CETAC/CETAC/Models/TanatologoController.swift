//
//  TanatologoController.swift
//  CETAC
//
//  Created by Paola Fernández on 06/10/21.
//

import Foundation
import Firebase

class TanatologoController{
    
    let db = Firestore.firestore()
    
    func fetchTanatologo(completion: @escaping (Result<Tanatologos, Error>) -> Void){
        var tanatologos = [Tanatologo]()
        db.collection("Tanatologo").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    let t = Tanatologo(aDoc: document)
                    print(t)
                    tanatologos.append(t)
                }
                completion(.success(tanatologos))
            }
        }
       
    }
    func getTanatologo(id:String, completion: @escaping (Result<Tanatologo, Error>) -> Void){
        var tanatologo:Tanatologo = Tanatologo(apellido: "", correo: "", nombre: "")
        db.collection("Tanatologo").document(id).getDocument() { (querySnapshot, err) in
            if let err = err {
                completion(.failure(err))
            } else {
                tanatologo = Tanatologo(aDoc: querySnapshot!)
                    print(tanatologo)
                }
                completion(.success(tanatologo))
            }
        }
       

}
