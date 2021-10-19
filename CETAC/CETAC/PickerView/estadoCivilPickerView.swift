//
//  estadoCivilPickerView.swift
//  CETAC
//
//  Created by Paola Fernández on 04/10/21.
//

import UIKit

class estadoCivilPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    let estadoCivil = ["Solterx", "Casadx", "Divorciadx", "Viudx"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return estadoCivil.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return estadoCivil[row]
    }
    
    func getSelected(_ pickerView: UIPickerView, selectedRow row: Int) -> String? {
        return estadoCivil[row]
    }

}
