//
//  MotivoChartViewController.swift
//  CETAC
//
//  Created by Yus Molina on 13/10/21.
//

import UIKit
import Charts
import TinyConstraints

class MotivoChartViewController: UIViewController {
    
    let motivoController = MotivoController()
    var motivos = [String: Int]()

    @IBOutlet weak var vistaBarras: UIView!
    lazy var horizontalBarChart: HorizontalBarChartView = {
        let horizontalBarChartView = HorizontalBarChartView()
        return horizontalBarChartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vistaBarras.addSubview(horizontalBarChart)
        horizontalBarChart.center(in: vistaBarras)
        horizontalBarChart.width(to: vistaBarras)
        horizontalBarChart.heightToWidth(of: vistaBarras)
        
        motivoController.fetchUsuarios(campo: "motivo"){ (result) in
            switch result{
            case .success(let usuarios):self.countMotivo(with: usuarios)
            case .failure(_):self.showError("No se pudo acceder a los usuarios")
            }
        }
    }
   
    func countMotivo(with usuarios:Usuarios){
        DispatchQueue.main.async {
            for use in usuarios{
                self.motivos[String(use.motivo)] = (self.motivos[String(use.motivo)] ?? 0) + 1
            }
            print(self.motivos)
            self.actualiza()
        }
    }
    
    func actualiza(){
        var sesionesArreglo = [BarChartDataEntry]()
        var i = 1.0
        var usuarios = [""]
        for (key, value) in motivos{
            sesionesArreglo.append(BarChartDataEntry(x: i, y: Double(value)))
            i += 1
            usuarios.append(key)
        }
        let sesionesDataSet = BarChartDataSet(entries: sesionesArreglo, label: "Motivo")
        let data = BarChartData(dataSet: sesionesDataSet)
        horizontalBarChart.data = data
        horizontalBarChart.chartDescription?.text = "Motivo"
        horizontalBarChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: usuarios)
        horizontalBarChart.notifyDataSetChanged()
    }
    
    func showError(_ message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
