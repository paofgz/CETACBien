//
//  servicioController.swift
//  CETAC
//
//  Created by Annya Verduzco on 16/10/21.
//

import Foundation
import Firebase

class servicioController{
    let db = Firestore.firestore()

    
    func fetchSesiones(_ idUsuario:String, completion: @escaping (Result<Sesiones, Error>) -> Void){
        var sesiones = [Sesion]()
        print(idUsuario)
        db.collection("Usuarios").document(idUsuario).collection("Sesion").order(by: "servicio").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    let s = Sesion(aDoc: document)
                    print(s)
                    sesiones.append(s)
                }
                completion(.success(sesiones))
            }
        }
       
    }
}


