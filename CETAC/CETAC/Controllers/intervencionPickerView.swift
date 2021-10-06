//
//  intervencionPickerView.swift
//  CETAC
//
//  Created by Paola Fernández on 04/10/21.
//

import UIKit

class intervencionPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    let intervenciones = ["Tanatología", "Acompañamiento Individual", "Acompañamiento Grupal", "Logoterapia", "Mindfulness", "Aromaterapia y Musicoterapia", "Cristaloterapia", "Reiki", "BIomagnetismo", "Angeloterapia", "Cama Térmica de Jade", "Flores de Bach", "Brisas ambientales"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return intervenciones.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return intervenciones[row]
    }
    
    func getSelected(_ pickerView: UIPickerView, selectedRow row: Int) -> String? {
        return intervenciones[row]
    }

}
