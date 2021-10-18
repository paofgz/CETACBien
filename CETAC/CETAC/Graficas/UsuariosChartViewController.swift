//
//  UsuariosChartViewController.swift
//  CETAC
//
//  Created by Yus Molina on 15/10/21.
//

import UIKit
import Charts
import TinyConstraints

class UsuariosChartViewController: UIViewController {
    var fechaInicio:Date = Date()
    var fechaFin:Date = Date()
    var motivoController = MotivoController()
    var tanatologoChartController = TanatologoChartController()
    var tanatologos = [String: Int]()
    var generos = [String: Int]()
    var tanatologosNombres = [" "]
    
    @IBOutlet weak var pastel: UIView!
    @IBOutlet weak var barras: UIView!
    
    lazy var pieChart: PieChartView = {
        let pieChartView = PieChartView()
        return pieChartView
    }()

    lazy var barChart: BarChartView = {
        let barChartView = BarChartView()
        return barChartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pastel.addSubview(pieChart)
        pieChart.center(in: pastel)
        pieChart.width(to: pastel)
        pieChart.heightToWidth(of: pastel)
        barras.addSubview(barChart)
        barChart.center(in: barras)
        barChart.width(to: barras)
        barChart.heightToWidth(of: barras)
        print(fechaInicio)
        print(fechaFin)
        
        motivoController.fetchUsuarios(fechaInicio: fechaInicio, fechaFinal: fechaFin){ (result) in
            switch result{
            case .success(let usuarios):self.countSexo(with: usuarios)
            case .failure(_):self.showError("No se pudo acceder a los usuarios")
            }
        }
        
        motivoController.fetchUsuarios(fechaInicio: fechaInicio, fechaFinal: fechaFin){ (result) in
            switch result{
            case .success(let usuarios):self.countTanatologo(with: usuarios)
            case .failure(_):self.showError("No se pudo acceder a los usuarios")
            }
        }
    }
  
    func countSexo(with usuarios:Usuarios){
        DispatchQueue.main.async {
            for use in usuarios{
                self.generos[String(use.sexo)] = (self.generos[String(use.sexo)] ?? 0) + 1
            }
            print(self.generos)
            self.pieChartUpdate()
        }
    }
    
    func countTanatologo(with usuarios:Usuarios){
        DispatchQueue.main.async {
            for use in usuarios{
                self.tanatologos[String(use.idTanatologo)] = (self.tanatologos[String(use.idTanatologo)] ?? 0) + 1
            }
            print(self.tanatologos)
            self.barChartUpdate()
        }
    }
    
    func pieChartUpdate () {
        var sesionesArreglo = [PieChartDataEntry]()
        var i = 1.0
        var usuarios = [""]
        for (key, value) in generos{
            sesionesArreglo.append(PieChartDataEntry(value: Double(value), label: key))
            i += 1
            usuarios.append(key)
        }
        let dataSet = PieChartDataSet(entries: sesionesArreglo, label: "Sexo")
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        pieChart.chartDescription?.text = "Usuarios atendidos por sexo"
        dataSet.colors = ChartColorTemplates.material()
        pieChart.holeColor = UIColor.clear
        pieChart.holeColor = UIColor.clear
        pieChart.chartDescription?.textColor = UIColor.blue
        pieChart.legend.textColor = UIColor.blue
        pieChart.notifyDataSetChanged()
    }
       
    func barChartUpdate () {
        var sesionesArreglo = [BarChartDataEntry]()
        var i = 1.0
        var tana = [String]()
        for (key, value) in tanatologos{
            sesionesArreglo.append(BarChartDataEntry(x: i, y: Double(value)))
            i += 1
            tana.append(key)
        }
        let sesionesDataSet = BarChartDataSet(entries: sesionesArreglo, label: "Tanatologo")
        let data = BarChartData(dataSet: sesionesDataSet)
        barChart.data = data
        barChart.chartDescription?.text = "Usuarios por tanatólogo"
        for tanatolo in tana{
            tanatologoChartController.fetchPerfil(email: tanatolo, perfil: "Tanatologo") {
                (st)in
                self.cargar(st: st)
            }
        }
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: tana)
        barChart.notifyDataSetChanged()
    }
    
    func cargar(st: String){
        DispatchQueue.main.async {
            self.tanatologosNombres.append(st)
            self.barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: self.tanatologosNombres)
            self.barChart.notifyDataSetChanged()
        }
    }
    func showError(_ message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}

