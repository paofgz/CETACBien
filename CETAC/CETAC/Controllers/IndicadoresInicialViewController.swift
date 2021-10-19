//
//  IndicadoresInicialViewController.swift
//  CETAC
//
//  Created by Yus Molina on 18/10/21.
//

import UIKit

class IndicadoresInicialViewController: UIViewController {
    
    @IBOutlet weak var fechaInicial: UIDatePicker!
    @IBOutlet weak var fechaFinal: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMotivos"{
            let siguienteVista = segue.destination as! MotivoChartViewController
            siguienteVista.fechaFin = fechaFinal.date
            siguienteVista.fechaInicio = fechaInicial.date
        }
        if segue.identifier == "toUsuarios"{
            let siguienteVista = segue.destination as! UsuariosChartViewController
            siguienteVista.fechaFin = fechaFinal.date
            siguienteVista.fechaInicio = fechaInicial.date
        }
        if segue.identifier == "toCuotas"{
            let siguienteVista = segue.destination as! CuotasChartViewController
            siguienteVista.fechaFin = fechaFinal.date
            siguienteVista.fechaInicio = fechaInicial.date
        }
        if segue.identifier == "toIntervenciones"{
            let siguienteVista = segue.destination as! ServicioIntervencionChartViewController
            siguienteVista.fechaFin = fechaFinal.date
            siguienteVista.fechaInicio = fechaInicial.date
        }
       
    }
    

}
