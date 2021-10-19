//
//  UsuarioController.swift
//  CETAC
//
//  Created by Paola Fernández on 28/09/21.
//
import Foundation
import Firebase


class UsuarioController{
    
    let db = Firestore.firestore()
    
    func fetchUsuarios(completion: @escaping (Result<Usuarios, Error>) -> Void){
        
        var usuarios = [Usuario]()
        db.collection("Usuarios").order(by: "nombre").getDocuments() { (querySnapshot, err) in
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
    
    func fetchUsuariosByTan(idTan:String, completion: @escaping (Result<Usuarios, Error>) -> Void){
        
        var usuarios = [Usuario]()
        db.collection("Usuarios").whereField("idTanatologo", isEqualTo: idTan).getDocuments() { (querySnapshot, err) in
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

    func insertUsuario(nuevoUsuario:Usuario, completion: @escaping (Result<String, Error>) -> Void){
        if nuevoUsuario.nombre == "" {
            print("El usuario debe tener un nombre")
            completion(.success("El usuario debe tener un nombre"))
        }else{
            var ref: DocumentReference? = nil
            ref = db.collection("Usuarios").addDocument(data: [
                "fecha": nuevoUsuario.fecha,
                "idTanatologo": nuevoUsuario.idTanatologo,
                "nombre": nuevoUsuario.nombre,
                "ocupacion": nuevoUsuario.ocupacion,
                "religion": nuevoUsuario.religion,
                "procedencia": nuevoUsuario.procedencia,
                "domicilio": nuevoUsuario.domicilio,
                "telefonoDeCasa": nuevoUsuario.telefonoDeCasa,
                "celular": nuevoUsuario.celular,
                "estadoCivil": nuevoUsuario.estadoCivil,
                "edadPareja": nuevoUsuario.edadPareja,
                "sexoPareja": nuevoUsuario.sexoPareja,
                "hijos": nuevoUsuario.hijos,
                "referido": nuevoUsuario.referido,
                "motivo": nuevoUsuario.motivo,
                "identificacionDeRespuesta": nuevoUsuario.identificacionDeRespuesta,
                "EKR": nuevoUsuario.EKR,
                "proximaSesion": nuevoUsuario.proximaSesion,
                "status": nuevoUsuario.status,
                "edad": nuevoUsuario.edad,
                "sexo": nuevoUsuario.sexo
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    completion(.failure(err))
                } else {
                    completion(.success(ref!.documentID))
                }
            }
        }
    }
    
    func getUsuario(id:String, completion: @escaping (Result<Usuario, Error>) -> Void){
        let now = Date()
        var usuario:Usuario = Usuario(fecha: now, idTanatologo: "", nombre: "", ocupacion: "", religion: "", procedencia: "", domicilio: "", telefonoDeCasa: "", celular: "", estadoCivil: "", edadPareja: 0, sexoPareja: "", hijos: "", referido: "", motivo: "", identificacionDeRespuesta: "", EKR: "", status: 0, proximaSesion: "", sexo: "", edad: 0)
        db.collection("Usuarios").document(id).getDocument() { (querySnapshot, err) in
            if let err = err {
                completion(.failure(err))
            } else {
                usuario = Usuario(aDoc: querySnapshot!)
                    print(usuario)
                }
                completion(.success(usuario))
            }
        }
    
    func updateProxSes(usuarioId:String, proxSes:String, completion: @escaping (Result<String, Error>) -> Void){
        db.collection("Usuarios").document(usuarioId).updateData([
            "proximaSesion": proxSes
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
    func updateStatus(usuarioId:String, status:Int, completion: @escaping (Result<String, Error>) -> Void){
        db.collection("Usuarios").document(usuarioId).updateData([
            "status": status
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
