//
//  SesionDetalleAdminViewController.swift
//  CETAC
//
//  Created by Paola Fernández on 18/10/21.
//

import UIKit

import Foundation
import UIKit

class SesionDetalleAdminViewController: UIViewController {

    var usuarioControlador = UsuarioController()
    var sesionControlador = SesionesController()
    var tanatologoControlador = TanatologoController()
    var validators = Validators()
    
    let dateFormatter = DateFormatter()
    var idUsuario: String?
    var laSesion: Sesion?
    var ind: Int?
    var elUsuario: Usuario?
    
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var guardarButton: UIButton!
    
    @IBOutlet weak var nomPas: UILabel!
    @IBOutlet weak var sesion: UILabel!
    @IBOutlet weak var numExp: UILabel!
    @IBOutlet weak var tan: UILabel!
    @IBOutlet weak var motiv: UILabel!
    @IBOutlet weak var serv: UILabel!
    @IBOutlet weak var int: UILabel!
    @IBOutlet weak var herr: UILabel!
    @IBOutlet weak var eval: UITextField!
    @IBOutlet weak var rec: UITextField!
    
    @IBOutlet weak var servPicker: servicioPickerView!
    @IBOutlet weak var intPicker: intervencionPickerView!
    @IBOutlet weak var herrPicker: herramientasPickerView!
    
    var editar = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setupToHideKeyboardOnTapOnView()
        
        self.servPicker.delegate = servPicker
        self.servPicker.dataSource = servPicker

        self.intPicker.delegate = intPicker
        self.intPicker.dataSource = intPicker
        
        self.herrPicker.delegate = herrPicker
        self.herrPicker.dataSource = herrPicker

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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editar = false
        botones(estado: editar)
        
        self.setupToHideKeyboardOnTapOnView()
        
        self.servPicker.delegate = servPicker
        self.servPicker.dataSource = servPicker

        self.intPicker.delegate = intPicker
        self.intPicker.dataSource = intPicker
        
        self.herrPicker.delegate = herrPicker
        self.herrPicker.dataSource = herrPicker
        
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
    
    func botones(estado:Bool){
        if estado{
            editButton.isHidden = true
            guardarButton.isHidden =  false
            cancelButton.isHidden =  false
            serv.isHidden = true
            int.isHidden = true
            herr.isHidden = true
            eval.isUserInteractionEnabled = true
            rec.isUserInteractionEnabled = true
            servPicker.isHidden = false
            intPicker.isHidden = false
            herrPicker.isHidden = false
            servPicker.set(servPicker, selectedServ: self.serv.text ?? "")
            intPicker.set(intPicker, selectedInt: self.int.text ?? "")
            herrPicker.set(herrPicker, selectedHerr: self.herr.text ?? "")
        }
        else{
            editButton.isHidden = false
            guardarButton.isHidden =  true
            cancelButton.isHidden =  true
            serv.isHidden = false
            int.isHidden = false
            herr.isHidden = false
            eval.isUserInteractionEnabled = false
            rec.isUserInteractionEnabled = false
            servPicker.isHidden = true
            intPicker.isHidden = true
            herrPicker.isHidden = true
        }
    }
    
    
    @IBAction func editarSesion(_ sender: UIButton) {
        editar = !editar
        botones(estado: editar)
    }
    
    @IBAction func cancelarEdicion(_ sender: UIButton) {
        editar = !editar
        botones(estado: editar)
    }
    
    @IBAction func guardarEdicion(_ sender: UIButton) {
        let error = validators.validateSesion(cuotaRec: self.rec.text ?? "0")
        if error != nil {
            displayExito(title: error ?? "", detalle: "Hay datos incorrectos")
        } else {
            editar = !editar
            botones(estado: editar)
            let servicio = self.servPicker.getSelected(servPicker, selectedRow: self.servPicker.selectedRow(inComponent: 0)) ?? ""
            let intervencion = self.intPicker.getSelected(intPicker, selectedRow: self.intPicker.selectedRow(inComponent: 0)) ?? ""
            let herramienta = self.herrPicker.getSelected(herrPicker, selectedRow: self.herrPicker.selectedRow(inComponent: 0)) ?? ""
            let cuota = Float(self.rec.text ?? "0")
            self.sesionControlador.updateSesion(usuarioId: self.elUsuario!.id, sesionId: self.laSesion!.id, serv: servicio, int: intervencion, herr: herramienta, eval: self.eval.text ?? "", rec: cuota ?? 0.0){ (result) in
                switch result{
                case .success(let retorno):
                    self.displayExito(title: retorno, detalle: "Se actualizó la sesion")
                case .failure(let error):self.displayError(error, title: "No se pudo modificar el registro")
                }
            }
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

