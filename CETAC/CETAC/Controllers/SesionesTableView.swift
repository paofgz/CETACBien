//
//  SesionesTableView.swift
//  CETAC
//
//  Created by Paola Fernández on 01/10/21.
//

import UIKit

class SesionesTableView: UITableView {
    var sesiones:[Sesion] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sesiones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(sesiones)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SesionesTableViewCell
        cell.update(index:indexPath.row, with: sesiones[indexPath.row])
        
        return cell
    }

}
