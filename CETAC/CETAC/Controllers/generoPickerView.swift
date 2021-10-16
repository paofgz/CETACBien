//
//  generoPickerView.swift
//  CETAC
//
//  Created by Paola Fernández on 15/10/21.
//

import UIKit

class generoPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    let generos = ["Mujer", "Hombre", "No binario", "Prefiero no decir"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return generos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return generos[row]
    }
    
    func getSelected(_ pickerView: UIPickerView, selectedRow row: Int) -> String? {
        return generos[row]
    }
}
