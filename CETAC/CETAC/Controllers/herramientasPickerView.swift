//
//  herramientasPickerView.swift
//  CETAC
//
//  Created by Paola Fernández on 04/10/21.
//

import UIKit

class herramientasPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    let herramientas = ["Contención", "Diálogo", "Ejercicio", "Encuadre", "Infografía", "Dinámica", "Lectura", "Meditación", "Video", "Otro"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return herramientas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return herramientas[row]
    }
    
    func getSelected(_ pickerView: UIPickerView, selectedRow row: Int) -> String? {
        return herramientas[row]
    }

}
