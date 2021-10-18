//
//  IndicadoresInicialViewController.swift
//  CETAC
//
//  Created by Yus Molina on 18/10/21.
//

import UIKit

class IndicadoresInicialViewController: UIViewController {
    
   // let dateFormatter = DateFormatter()


    @IBOutlet weak var fechaInicial: UIDatePicker!
    @IBOutlet weak var fechaFinal: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // var a = fechaInicial.date

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
