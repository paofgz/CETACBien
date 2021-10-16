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
    
    func fetchUsuarios(campo: String, completion: @escaping (Result<[Usuario], Error>) -> Void){
        var usuarios = [Usuario]()
        
        db.collection("Usuarios").order(by: campo).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    let u = Usuario(aDoc: document)
                    usuarios.append(u)
                }
                completion(.success(usuarios))
            }
        }
    }
  
}
