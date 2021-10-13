//
//  MotivoController.swift
//  CETAC
//
//  Created by Yus Molina on 13/10/21.
//

import Foundation
import Firebase

class MotivoController{
    let db = Firestore.firestore()
/*
    func fetchData() {
            db.collection("Usuarios").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                print(documents)
            }
        }*/
    
    
    func fetchUsuarios(completion: @escaping (Result<[Usuario], Error>) -> Void){
        
        var usuarios = [Usuario]()
        db.collection("Usuarios").order(by: "motivo").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                print(querySnapshot!.documents)
              
                for document in querySnapshot!.documents {
                    let u = Usuario(aDoc: document)
                    usuarios.append(u)
                }
                completion(.success(usuarios))
            }
        }
       
    }
}
