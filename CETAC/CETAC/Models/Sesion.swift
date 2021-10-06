//
//  Sesion.swift
//  CETAC
//
//  Created by Paola Fernández on 06/10/21.
//

import Foundation
import Firebase

struct Sesion: Codable {
    let cerrarExpediente: Bool
    let cuotaDeRecuperacion: Float
    let id, herramienta, tipoDeIntervencion, evaluacionSesion, servicio: String
    let fecha: Date
    init(id:String, fecha:Date, herramienta:String, servicio:String, tipoDeIntervencion:String, evaluacionSesion:String, cuotaDeRecuperacion:Float, cerrarExpediente:Bool){
            self.id = id
            self.fecha = fecha
            self.herramienta = herramienta
            self.servicio = servicio
            self.tipoDeIntervencion = tipoDeIntervencion
            self.evaluacionSesion = evaluacionSesion
            self.cuotaDeRecuperacion = cuotaDeRecuperacion
            self.cerrarExpediente = cerrarExpediente
    }

    init(fecha:Date, herramienta:String, tipoDeIntervencion:String, evaluacionSesion:String, servicio:String, cuotaDeRecuperacion:Float, cerrarExpediente:Bool){
            self.id = ""
            self.fecha = fecha
            self.herramienta = herramienta
            self.servicio = servicio
            self.tipoDeIntervencion = tipoDeIntervencion
            self.evaluacionSesion = evaluacionSesion
            self.cuotaDeRecuperacion = cuotaDeRecuperacion
            self.cerrarExpediente = cerrarExpediente
    }

    init(aDoc: DocumentSnapshot){
        self.id = aDoc.documentID
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = aDoc.get("fecha") as AnyObject
        self.fecha = date.dateValue()
        self.herramienta = aDoc.get("herramienta") as? String ?? ""
        self.servicio = aDoc.get("servicio") as? String ?? ""
        self.tipoDeIntervencion = aDoc.get("tipoDeIntervencion") as? String ?? ""
        self.evaluacionSesion = aDoc.get("evaluacionSesion") as? String ?? ""
        self.cuotaDeRecuperacion = aDoc.get("cuotaDeRecuperacion") as? Float ?? 0.0
        self.cerrarExpediente = aDoc.get("cerrarExpediente") as? Bool ?? false
    }
}

typealias Sesiones = [Sesion]

