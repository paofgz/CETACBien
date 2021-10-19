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
    
    func fetchUsuarios(fechaInicio: Date, fechaFinal: Date, completion: @escaping (Result<[Usuario], Error>) -> Void){
        var usuarios = [Usuario]()
        //                                                          fecha grande - fecha peque
        db.collection("Usuarios").whereField("fecha", isLessThan: fechaFinal).whereField("fecha", isGreaterThan: fechaInicio).getDocuments() { (querySnapshot, err) in
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
    /*
    func fetchSesiones(_ idUsuario:String, fechaInicio: Date, fechaFinal: Date, completion: @escaping (Result<Sesiones, Error>) -> Void){
        var sesiones = [Sesion]()
        db.collection("Usuarios").document(idUsuario).collection("Sesion").whereField("fecha", isLessThan: fechaFinal).whereField("fecha", isGreaterThan: fechaInicio).getDocuments() { (querySnapshot, err) in
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
       
    }*/
    
    func fetchUsuariosByTan(idTan:String, fechaInicio: Date, fechaFinal: Date, completion: @escaping (Result<Usuarios, Error>) -> Void){
        
        //.whereField("fecha", isGreaterThan: fechaInicio).whereField("fecha", isLessThan: fechaFinal)
        //
        var usuarios = [Usuario]()
        db.collection("Usuarios").whereField("idTanatologo", isEqualTo: idTan).whereField("fecha", isGreaterThan: fechaInicio).whereField("fecha", isLessThan: fechaFinal).getDocuments() { (querySnapshot, err) in
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
    /*
    func fetchTanatologo(fechaInicio: Date, fechaFinal: Date,completion: @escaping (Result<Tanatologos, Error>) -> Void){
        var tanatologos = [Tanatologo]()
        db.collection("Tanatologo").whereField("fecha", isLessThan: fechaFinal).whereField("fecha", isGreaterThan: fechaInicio).getDocuments() { (querySnapshot, err) in
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
       
    }*/
  
}
