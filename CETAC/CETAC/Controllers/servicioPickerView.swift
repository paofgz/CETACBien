//
//  servicioPickerView.swift
//  CETAC
//
//  Created by Paola Fernández on 04/10/21.
//

import UIKit

class servicioPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    let servicios = ["Servicios de Acompañamiento", "Servicios holísticos", "Herramientas alternativas"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return servicios.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return servicios[row]
    }
    
    func getSelected(_ pickerView: UIPickerView, selectedRow row: Int) -> String? {
        return servicios[row]
    }
    
    func set(_ pickerView: UIPickerView, selectedServ: String) -> Void {
        let ind = servicios.firstIndex(of: selectedServ) ?? 0
        selectRow(ind, inComponent: 0, animated: false)
    }

}
