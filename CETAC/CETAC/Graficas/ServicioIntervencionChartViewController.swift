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
    var fechaInicio:Date = Date()
    var fechaFin:Date = Date()
    
    let ControladorServicio = servicioController()

    @IBOutlet weak var vistaInt: UIView!
    @IBOutlet weak var vistaServicio: UIView!
    
    lazy var BarChartHorizaontal: HorizontalBarChartView = {
        let horizontalBarChartView = HorizontalBarChartView()
        return horizontalBarChartView
    }()
    lazy var BarChartHorizontalServ: HorizontalBarChartView = {
        let horizontalBarChartView = HorizontalBarChartView()
        return horizontalBarChartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vistaInt.addSubview(BarChartHorizaontal)
        BarChartHorizaontal.center(in: vistaInt)
        BarChartHorizaontal.width(to: vistaInt)
        BarChartHorizaontal.heightToWidth(of: vistaInt)
       
        vistaServicio.addSubview(BarChartHorizontalServ)
        BarChartHorizontalServ.center(in: vistaServicio)
        BarChartHorizontalServ.width(to: vistaServicio)
        BarChartHorizontalServ.heightToWidth(of: vistaServicio)
        
        ControladorServicio.fetchSesiones(fechaInicio: fechaInicio, fechaFin: fechaFin){ (result) in
            switch result{
            case .success(let sesion):
                self.nueva(with: sesion)
                self.new(with: sesion)
            case .failure(_):print("No se pudo acceder a sesiones")
            }
        }
    }
    
    var tipoDeIntervencion = [String: Int]()
    func nueva(with sesiones:Sesiones){
        
        DispatchQueue.main.async {
            if sesiones.count > 0 {
                for use in sesiones{
                    self.tipoDeIntervencion[String(use.tipoDeIntervencion)] = (self.tipoDeIntervencion[String(use.tipoDeIntervencion)] ?? 0) + 1
                }
                print(self.tipoDeIntervencion)
                self.actualiza()
            }else{
                print("no hay datos")
            }
        }
    }
    
    func actualiza(){
        var sesionesArreglo = [BarChartDataEntry]()
        var i = 1.0
        var sesiones = [""]

        for (key, value) in tipoDeIntervencion{
            sesionesArreglo.append(BarChartDataEntry(x: i, y: Double(value)))
            i += 1
            sesiones.append(key)
        }
        print(sesiones)
       
        let sesionesDataSet = BarChartDataSet(entries: sesionesArreglo, label: "Intervencion")
        let data = BarChartData(dataSet: sesionesDataSet)
        BarChartHorizaontal.data = data
        BarChartHorizaontal.chartDescription?.text = "Sesiones"
        
        BarChartHorizaontal.xAxis.valueFormatter = IndexAxisValueFormatter(values: sesiones)
        BarChartHorizaontal.xAxis.granularity = 1
        //horizontalBarChart.backgroundColor = ChartColorTemplates.vordiplom()
        BarChartHorizaontal.notifyDataSetChanged()
        
    }
    

    var servicio = [String: Int]()
    func new(with sesiones:Sesiones){
        
        DispatchQueue.main.async {
            if sesiones.count > 0 {
                for use in sesiones{
                    self.servicio[String(use.servicio)] = (self.servicio[String(use.servicio)] ?? 0) + 1
                }
                print(self.servicio)
                self.update()
            }else{
                print("no hay datos")
            }

        }
    }
    func update(){
        var sesionesArreglo = [BarChartDataEntry]()
        var i = 1.0
        var sesiones = [""]
        for (key, value) in servicio{
            sesionesArreglo.append(BarChartDataEntry(x: i, y: Double(value)))
            i += 1
            sesiones.append(key)
        }
       
        let sesionesDataSet = BarChartDataSet(entries: sesionesArreglo, label: "Servicio")
        let data = BarChartData(dataSet: sesionesDataSet)
        BarChartHorizontalServ.data = data
        BarChartHorizontalServ.chartDescription?.text = "Sesiones"
        
        BarChartHorizontalServ.xAxis.valueFormatter = IndexAxisValueFormatter(values: sesiones)
        BarChartHorizontalServ.xAxis.granularity = 1

        BarChartHorizontalServ.notifyDataSetChanged()
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
