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
        
        motivoController.fetchUsuarios{ (result) in
            switch result{
            case .success(let usuarios):self.nueva(with: usuarios)
            case .failure(let error):print("No se pudo acceder a los usuarios")
            }
            
        }
        
        
        //actualiza()
        // Do any additional setup after loading the view.
    }
    var motivos = [String: Int]()
    func nueva(with usuarios:Usuarios){
        
        DispatchQueue.main.async {
            
            //print(usuarios)
            for use in usuarios{
                self.motivos[String(use.motivo)] = (self.motivos[String(use.motivo)] ?? 0) + 1
                //print(use.motivo)
                
            }
            print(self.motivos)
            //let groupedDictionary = Dictionary(grouping: usuarios, by: {String($0.motivo.prefix(1))})
            //let keys = groupedDictionary.keys.sorted()
           // print(groupedDictionary)            //self.datos = usuarios
            //self.tableView.reloadData()
            self.actualiza()

        }
    }
    func actualiza(){
        var sesionesArreglo = [BarChartDataEntry]()
        var i = 1.0
        var usuarios = [""]
        //let groupedDictionary = Dictionary(grouping: usuarios, by: {String($0.nombre.prefix(1))})
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
        //horizontalBarChart.backgroundColor = ChartColorTemplates.vordiplom()

        horizontalBarChart.notifyDataSetChanged()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
