//
//  Tanatologo.swift
//  CETAC
//
//  Created by Paola Fernández on 06/10/21.
//

import Foundation
import Firebase

struct Tanatologo: Codable {
    let apellido, correo, nombre, uid: String

    init(apellido:String, correo:String, nombre:String, uid: String){
        self.uid = uid
        self.apellido = apellido
        self.correo = correo
        self.nombre = nombre
    }

    init(apellido:String, correo:String, nombre:String){
        self.uid = ""
        self.apellido = apellido
        self.correo = correo
        self.nombre = nombre
    }
    
    init(aDoc: DocumentSnapshot){
        self.uid = aDoc.get("uid") as? String ?? ""
        self.apellido = aDoc.get("apellido") as? String ?? ""
        self.correo = aDoc.get("correo") as? String ?? ""
        self.nombre = aDoc.get("nombre") as? String ?? ""
    }
}

typealias Tanatologos = [Tanatologo]


