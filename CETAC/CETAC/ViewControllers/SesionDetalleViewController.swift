//
//  SesionDetalleViewController.swift
//  CETAC
//
//  Created by Paola Fernández on 16/10/21.
//

import Foundation
import UIKit

class SesionDetalleViewController: UIViewController {

    var usuarioControlador = UsuarioController()
    var sesionControlador = SesionesController()
    var tanatologoControlador = TanatologoController()
    
    let dateFormatter = DateFormatter()
    var idUsuario: String?
    var laSesion: Sesion?
    var ind: Int?
    var elUsuario: Usuario?
    
    @IBOutlet weak var nomPas: UILabel!
    @IBOutlet weak var sesion: UILabel!
    @IBOutlet weak var numExp: UILabel!
    @IBOutlet weak var tan: UILabel!
    @IBOutlet weak var motiv: UILabel!
    @IBOutlet weak var serv: UILabel!
    @IBOutlet weak var int: UILabel!
    @IBOutlet weak var herr: UILabel!
    @IBOutlet weak var eval: UILabel!
    @IBOutlet weak var rec: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usuarioControlador.getUsuario(id: self.idUsuario!){
            (res) in
            switch res{
            case .success(let usuario):
                self.elUsuario = usuario
                self.tanatologoControlador.getTanatologo(id: self.elUsuario!.idTanatologo){(res) in
                    switch res{
                    case .success(let tanatologo):self.updateUI(tanatologo:tanatologo, ind:self.ind ?? 0)
                    case .failure(_):print("No se pudo acceder a los tanatolgos")
                    }
                }
            case.failure(_): print("No se pudo acceder a los usuarios")
            }
        }
        // Do any additional setup after loading the view
    
    }
    
    func updateUI(tanatologo:Tanatologo, ind:Int) {
        DispatchQueue.main.async {
            self.nomPas.text = self.elUsuario?.nombre
            if ind == 0{
                self.sesion.text = "Encuadre"
            } else {
                self.sesion.text = "Sesion \(ind)"
            }
            self.numExp.text = self.idUsuario
            self.tan.text = tanatologo.nombre + " " + tanatologo.apellido
            self.motiv.text = self.elUsuario?.motivo
            self.serv.text = self.laSesion?.servicio
            self.int.text = self.laSesion?.tipoDeIntervencion
            self.herr.text = self.laSesion?.herramienta
            self.eval.text = self.laSesion?.evaluacionSesion
            self.rec.text = String(format: "%.2f", self.laSesion?.cuotaDeRecuperacion as! CVarArg)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func displayError(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    func displayExito(title: String, detalle:String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: detalle, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
}
