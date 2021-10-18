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
        //                                                          fecha grande - fecha peque
        db.collection("Usuarios").whereField("fecha", isLessThan: "10-10-2021 23:12").whereField("fecha", isGreaterThan: "09-10-2021 00:12").getDocuments() { (querySnapshot, err) in
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
