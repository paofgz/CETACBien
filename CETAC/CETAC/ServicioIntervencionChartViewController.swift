//
//  ServicioIntervencionChartViewController.swift
//  CETAC
//
//  Created by Annya Verduzco on 15/10/21.
//

import UIKit
import Charts
import TinyConstraints

class ServicioIntervencionChartViewController: UIViewController {

    let ControladorIntervencion = intervencionController()

    @IBOutlet weak var vistaInt: UIView!
    
    lazy var BarChartHorizaontal: HorizontalBarChartView = {
        let horizontalBarChartView = HorizontalBarChartView()
        return horizontalBarChartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vistaInt.addSubview(BarChartHorizaontal)
        BarChartHorizaontal.center(in: vistaInt)
        BarChartHorizaontal.width(to: vistaInt)
        BarChartHorizaontal.heightToWidth(of: vistaInt)
        
        
        ControladorIntervencion.fetchSesiones("j5i61tqFd53Is97D5RI1"){ (result) in
            switch result{
            case .success(let sesion):self.nueva(with: sesion)
            case .failure(_):print("No se pudo acceder a sesiones")
            }
            
        }
        
        
        //actualiza()
        // Do any additional setup after loading the view.
    }
    var tipoDeIntervencion = [String: Int]()
    func nueva(with sesiones:Sesiones){
        
        DispatchQueue.main.async {
            
            
            for use in sesiones{
                self.tipoDeIntervencion[String(use.tipoDeIntervencion)] = (self.tipoDeIntervencion[String(use.tipoDeIntervencion)] ?? 0) + 1
                //print(use.motivo)
                
            }
            print(self.tipoDeIntervencion)
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
        var sesiones = [""]
        //let groupedDictionary = Dictionary(grouping: usuarios, by: {String($0.nombre.prefix(1))})
        for (key, value) in tipoDeIntervencion{
            sesionesArreglo.append(BarChartDataEntry(x: i, y: Double(value)))
            i += 1
            sesiones.append(key)
        }
        
       
        let sesionesDataSet = BarChartDataSet(entries: sesionesArreglo, label: "Intervencion")
        let data = BarChartData(dataSet: sesionesDataSet)
        BarChartHorizaontal.data = data
        BarChartHorizaontal.chartDescription?.text = "Sesiones"
        
        BarChartHorizaontal.xAxis.valueFormatter = IndexAxisValueFormatter(values: sesiones)
        //horizontalBarChart.backgroundColor = ChartColorTemplates.vordiplom()

        BarChartHorizaontal.notifyDataSetChanged()
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
