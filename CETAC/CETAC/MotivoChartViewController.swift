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
        
        
        actualiza()
        // Do any additional setup after loading the view.
    }
    
    func nueva(with usuarios:Usuarios){
        print(usuarios)
        DispatchQueue.main.async {
            print("a")
            //self.datos = usuarios
            //self.tableView.reloadData()
        }
    }
    func actualiza(){
        
        //let groupedDictionary = Dictionary(grouping: usuarios, by: {String($0.nombre.prefix(1))})

        let punto1 = BarChartDataEntry(x: 1, y: 5)
        let punto2 = BarChartDataEntry(x: 2, y: 8)
        let punto3 = BarChartDataEntry(x: 3, y: 1)
        let punto4 = BarChartDataEntry(x: 4, y: 10)
        var sesionesArreglo = [BarChartDataEntry]()
        sesionesArreglo.append(punto1)
        sesionesArreglo.append(punto2)
        sesionesArreglo.append(punto3)
        sesionesArreglo.append(punto4)
        let sesionesDataSet = BarChartDataSet(entries: sesionesArreglo, label: "Motivo")
        let data = BarChartData(dataSet: sesionesDataSet)
        horizontalBarChart.data = data
        horizontalBarChart.chartDescription?.text = "Motivo"
        let usuarios = ["", "Karen", "Luis", "Jonatan", "Hector"]
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
