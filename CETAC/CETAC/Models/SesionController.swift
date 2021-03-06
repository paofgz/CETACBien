//
//  SesionController.swift
//  CETAC
//
//  Created by Paola Fernández on 30/09/21.
//

import Foundation
import Firebase

class SesionesController{
    
    let db = Firestore.firestore()
    
    func fetchSesiones(_ idUsuario:String, completion: @escaping (Result<Sesiones, Error>) -> Void){
        var sesiones = [Sesion]()
        db.collection("Usuarios").document(idUsuario).collection("Sesion").order(by: "fecha").getDocuments() { (querySnapshot, err) in
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

    func insertSesion(idUsuario:String, nuevaSesion:Sesion, completion: @escaping (Result<String, Error>) -> Void){
        
        var ref: DocumentReference? = nil
        ref = db.collection("Usuarios").document(idUsuario).collection("Sesion").addDocument(data: [
            "fecha": nuevaSesion.fecha,
            "herramienta": nuevaSesion.herramienta,
            "servicio": nuevaSesion.servicio,
            "tipoDeIntervencion": nuevaSesion.tipoDeIntervencion,
            "evaluacionSesion": nuevaSesion.evaluacionSesion,
            "cuotaDeRecuperacion": nuevaSesion.cuotaDeRecuperacion,
            "cerrarExpediente": nuevaSesion.cerrarExpediente
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(.failure(err))
            } else {
                completion(.success(ref!.documentID))
            }
        }
    }
    
    func updateSesion(usuarioId:String, sesionId:String, serv:String, int:String, herr:String, eval:String, rec:Float, completion: @escaping (Result<String, Error>) -> Void){
        db.collection("Usuarios").document(usuarioId).collection("Sesion").document(sesionId).updateData([
            "servicio": serv,
            "tipoDeIntervencion": int,
            "herramienta": herr,
            "evaluacionSesion": eval,
            "cuotaDeRecuperacion": rec
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(.failure(err))
            } else {
                print("Document successfully updated")
                completion(.success("Document successfully updated"))
            }
        }
    }
}


