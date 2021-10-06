//
//  UsuarioTableViewCell.swift
//  CETAC
//
//  Created by Paola Fernández on 28/09/21.
//
import UIKit

class UsuarioTableViewCell: UITableViewCell {
    

    @IBOutlet weak var nombreUsuario: UILabel!
    @IBOutlet weak var semaforo: UIImageView!
    
    func update(with usuario:Usuario){
        semaforo.layer.borderWidth = 1
        semaforo.layer.masksToBounds = false
        semaforo.layer.borderColor = UIColor.white.cgColor
        semaforo.layer.cornerRadius = semaforo.frame.height/2
        semaforo.clipsToBounds = true
        nombreUsuario.text = usuario.nombre
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let convertedDate = dateFormatter.date(from: usuario.proximaSesion)
        let now = Date()
        if ((convertedDate == nil || convertedDate! < now) && usuario.status == 1) {
            semaforo.image = UIImage(named: "amarillo")
        } else if (convertedDate == nil && usuario.status == 0) {
            semaforo.image = UIImage(named: "rojo")
        } else {
            semaforo.image = UIImage(named: "verde")
        }
    }
    
}
