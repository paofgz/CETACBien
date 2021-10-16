//
//  SesionTableViewCell.swift
//  CETAC
//
//  Created by Paola Fernández on 15/10/21.
//

import UIKit

class SesionTableViewCell: UITableViewCell {

    @IBOutlet weak var nomSes: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func update(with sesion:Sesion, index:Int){
        if (index == 0) {
            self.nomSes.text = "Encuadre"
        } else {
            self.nomSes.text = "Sesion \(index)"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let convertedDate = dateFormatter.string(from: sesion.fecha)
        date.text = convertedDate
    }

}
