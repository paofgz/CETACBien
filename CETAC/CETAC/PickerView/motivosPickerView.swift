//
//  motivosPickerView.swift
//  CETAC
//
//  Created by Paola Fernández on 04/10/21.
//

import UIKit

class motivosPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    let motivos = ["Abuso", "Adicción", "Ansiedad", "Baja Autoestima", "Codependencia", "Comunicación familiar", "Conflicto con hermano", "Conflicto con madre", "Conflicto con padre", "Dependencia", "Divorcio", "Duelo", "Duelo Grupal", "Enfermedad", "Enfermedad Crónico degenerativa", "Heridas de la infancia", "Identidad de género", "Infertilidad", "Infidelidad", "Intento de suicidio", "Miedo", "Pérdida de vienes materiales", "Pérdida de identidad", "Pérdida laboral", "Relación con los padres", "Ruptura de noviazgo", "Stress", "Trastorno Obsesivo", "Violación", "Violencia Intrafamiliar", "Violencia Psicológica", "Viudez", "Otro"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return motivos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return motivos[row]
    }
    
    func getSelected(_ pickerView: UIPickerView, selectedRow row: Int) -> String? {
        return motivos[row]
    }
}
