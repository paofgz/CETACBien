//
//  IndicadoresViewController.swift
//  CETAC
//
//  Created by Yus Molina on 18/10/21.
//

import UIKit

class IndicadoresViewController: UIViewController {

    @IBOutlet weak var fechaInicio: UIDatePicker!
    @IBOutlet weak var fechaFin: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(fechaFin)
        print(fechaInicio)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cambioInicio(_ sender: Any) {
        print(fechaFin.date)
        print(fechaInicio.date)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMotivos"{
            var siguienteVista = segue.destination as! MotivoChartViewController
            siguienteVista.fechaFinal = "lala"
            siguienteVista.fechaInicial = "fafa"
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
