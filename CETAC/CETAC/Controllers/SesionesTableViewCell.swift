//
//  SesionesTableViewCell.swift
//  CETAC
//
//  Created by Paola Fernández on 01/10/21.
//

import UIKit

class SesionesTableViewCell: UITableViewCell {

    @IBOutlet weak var Sesion: UILabel!
    @IBOutlet weak var Fecha: UILabel!
    
    func update(index:Int, with sesion:Sesion){
        if (index == 0) {
            Sesion.text = "Sesión de encuadre"
        } else {
            Sesion.text = "Sesión " + String(index)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        Fecha.text = dateFormatter.string(from: sesion.fecha)
    }
    
    
}
