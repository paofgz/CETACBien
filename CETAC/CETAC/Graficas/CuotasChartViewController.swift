//
//  CuotasChartViewController.swift
//  CETAC
//
//  Created by Paola Fernández on 16/10/21.
//

import UIKit
import Charts
import TinyConstraints

class CuotasChartViewController: UIViewController {
    var fechaInicio:Date = Date()
    var fechaFin:Date = Date()
    
    let cuotasControlador = CuotasController()
    @IBOutlet weak var cuotaGlobal: UILabel!
    @IBOutlet weak var grafica: UIView!
    
    lazy var barChart: BarChartView = {
        let barChartView = BarChartView()
        return barChartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grafica.addSubview(barChart)
        barChart.center(in: grafica)
        barChart.width(to: grafica)
        barChart.heightToWidth(of: grafica)
      

        cuotasControlador.fetchCuotasGlobales(fechaInicio: fechaInicio, fechaFin: fechaFin){
            (result) in
            switch result {
            case .success(let cuota): self.cuotaGlobal.text = "$" + String(format: "%.2f", cuota)
            case .failure(_):print("No se pudo acceder a las cuotas globales")
            }
        }

        cuotasControlador.fetchCuotasByTan(fechaInicio: fechaInicio, fechaFin: fechaFin){
            (result) in
            switch result {
            case .success(let cuotas):
                //print(cuotas)
                self.nueva(with: cuotas)
            case .failure(_):print("No se pudo acceder a las cuotas globales")
            }
        }
    }
    
    func nueva(with cuotas:[String:Double]){
        barChart.noDataTextColor = UIColor.white
        barChart.noDataText = "No hay datos disponibles"
        barChart.backgroundColor = UIColor.white
        
        var arreglo = [BarChartDataEntry]()
        var i = 1.0
        var tanatologos = [""]
        if cuotas.count > 0 {
            for (key, value) in cuotas{
                arreglo.append(BarChartDataEntry(x: i, y: value))
                i += 1
                tanatologos.append(key)
            }
        }else{
            print("no hay datos")
        }
       
        let dataSet = BarChartDataSet(entries: arreglo, label: "Cuota")
        let data = BarChartData(dataSet: dataSet)
        barChart.data = data
        dataSet.colors = [color1]
        barChart.chartDescription?.enabled = false
        
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: tanatologos)
        barChart.xAxis.granularity = 1
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.legend.enabled = true
        barChart.rightAxis.enabled = false
        barChart.leftAxis.drawLabelsEnabled = true
        //horizontalBarChart.backgroundColor = ChartColorTemplates.vordiplom()

        barChart.notifyDataSetChanged()
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
