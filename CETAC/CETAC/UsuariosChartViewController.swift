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
    var motivoController = MotivoController()
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
        
        motivoController.fetchUsuarios2(campo: "sexo"){ (result) in
            switch result{
            //case .success(let usuarios):print( usuarios)

            case .success(let usuarios):self.nueva(with: usuarios)
            case .failure(let error):print("No se pudo acceder a los usuarios")
            }
            
        }
        motivoController.fetchUsuarios2(campo: "idTanatologo"){ (result) in
            switch result{
            //case .success(let usuarios):print( usuarios)

            case .success(let usuarios):self.nueva2(with: usuarios)
            case .failure(let error):print("No se pudo acceder a los usuarios")
            }
            
        }
        //pieChartUpdate()
        barChartUpdate()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    var generos = [String: Int]()
    func nueva(with usuarios:Usuarios){
        
        DispatchQueue.main.async {
            
            //print(usuarios)
            for use in usuarios{
                self.generos[String(use.sexo)] = (self.generos[String(use.sexo)] ?? 0) + 1
                //print(use.motivo)
                
            }
            print(self.generos)
            //let groupedDictionary = Dictionary(grouping: usuarios, by: {String($0.motivo.prefix(1))})
            //let keys = groupedDictionary.keys.sorted()
           // print(groupedDictionary)            //self.datos = usuarios
            //self.tableView.reloadData()
            self.pieChartUpdate()

        }
    }
    var tanatologos = [String: Int]()
    
    func nueva2(with usuarios:Usuarios){
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
        //pieChart.backgroundColor = UIColor.black
        pieChart.holeColor = UIColor.clear
       // pieChart.chartDescription?.textColor = UIColor.black
        //pieChart.legend.textColor = UIColor.black
        pieChart.holeColor = UIColor.clear
        pieChart.chartDescription?.textColor = UIColor.blue
        pieChart.legend.textColor = UIColor.blue
        pieChart.notifyDataSetChanged()
    }
        
    func barChartUpdate () {
        var sesionesArreglo = [BarChartDataEntry]()
        var i = 1.0
        var usuarios = [""]
        //let groupedDictionary = Dictionary(grouping: usuarios, by: {String($0.nombre.prefix(1))})
        for (key, value) in tanatologos{
            sesionesArreglo.append(BarChartDataEntry(x: i, y: Double(value)))
            i += 1
            usuarios.append(key)
        }
        let sesionesDataSet = BarChartDataSet(entries: sesionesArreglo, label: "tanatologo")

        let data = BarChartData(dataSet: sesionesDataSet)
 
        //let dataSet = BarChartDataSet(entries: [entry1, entry2, entry3], label: "Usuarios por motivo")
        //let data = BarChartData(dataSet: dataSet)
        barChart.data = data
        barChart.chartDescription?.text = "Usuarios por tanatólogo"
        
       // let generos = ["Inicio", "Addición", "Conflicto", "Stress", "Pérdida"]
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: usuarios)
//        barChart.xAxis.granularity = 0

        barChart.notifyDataSetChanged()
    }
    /*
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
     */

}
