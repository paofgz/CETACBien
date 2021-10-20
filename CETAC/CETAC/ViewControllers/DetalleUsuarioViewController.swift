//
//  DetalleUsuarioViewController.swift
//  CETAC
//
//  Created by Paola Fernández on 30/09/21.
//

import Foundation
import UIKit

class DetalleUsuarioViewController: UIViewController {
    
    var usuarioControlador = UsuarioController()
    var sesionControlador = SesionesController()
    var tanatologoControlador = TanatologoController()
    var usuarioTable = UsuariosTableViewController()
    var usuarioTanTable = UsuariosTanTableViewController()
    var validator = Validators()
    
    let dateFormatter = DateFormatter()
    
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var status: UIImageView!
    var elUsuario: Usuario?
    var editar = false

    @IBOutlet weak var sexo: UITextField!
    @IBOutlet weak var edad: UITextField!
    @IBOutlet weak var numExp: UILabel!
    @IBOutlet weak var numSes: UILabel!
    @IBOutlet weak var motiv: UILabel!
    @IBOutlet weak var serv: UILabel!
    @IBOutlet weak var tan: UILabel!
    @IBOutlet weak var int: UILabel!
    @IBOutlet weak var herr: UILabel!
    @IBOutlet weak var ultSes: UILabel!
    @IBOutlet weak var proxSes: UILabel!
    @IBOutlet weak var pickProxSes: UIDatePicker!
    
    @IBOutlet weak var eliminarCita: UIButton!
    
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var sesionesPas: UIView!
    weak var embedvc:SesionesTableViewController?
    
    var sesiones:[Sesion] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sesionControlador.fetchSesiones(self.elUsuario!.id){ (result) in
                    switch result{
                    case .success(let sesiones):
                        self.tanatologoControlador.getTanatologo(id: self.elUsuario!.idTanatologo){(res) in
                                switch res{
                                case .success(let tanatologo):self.updateUI(with: sesiones, tanatologo: tanatologo)
                                case .failure(_):print("No se pudo acceder a los tanatolgos")
                                }
                        }
                    case .failure(_):print("No se pudo acceder a las sesiones")
            }
        }
        self.navigationController?.navigationBar.topItem?.title = elUsuario?.nombre;
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.embedvc?.idUsuario = elUsuario?.id ?? ""
        editar = false
        botones(estado: editar)
        if (elUsuario != nil) {
            print(elUsuario ?? "")
        }
        status.layer.borderWidth = 1
        status.layer.masksToBounds = false
        status.layer.borderColor = UIColor.white.cgColor
        status.layer.cornerRadius = status.frame.height/2
        status.clipsToBounds = true
        sesionControlador.fetchSesiones(self.elUsuario!.id){ (result) in
                    switch result{
                    case .success(let sesiones):
                        self.tanatologoControlador.getTanatologo(id: self.elUsuario!.idTanatologo){(res) in
                                switch res{
                                case .success(let tanatologo):self.updateUI(with: sesiones, tanatologo:tanatologo)
                                case .failure(_):print("No se pudo acceder a los tanatolgos")
                                }
                        }
                    case .failure(_):print("No se pudo acceder a las sesiones")
            }
        }
    }
        
        
    func updateUI(with sesiones:Sesiones, tanatologo:Tanatologo) {
        DispatchQueue.main.async {
            let length = sesiones.count
            let lastSes = sesiones[length-1]
            self.nombre.text = self.elUsuario?.nombre
            let edad = self.elUsuario?.edad ?? 0
            self.edad.text = String(edad)
            self.sexo.text = self.elUsuario?.sexo
            self.numExp.text = self.elUsuario?.id
            let numero = self.elUsuario?.numSes ?? 0
            self.numSes.text = String(numero)
            self.motiv.text = self.elUsuario?.motivo
            self.serv.text = lastSes.servicio
            self.tan.text = tanatologo.nombre + " " + tanatologo.apellido
            self.int.text = lastSes.tipoDeIntervencion
            self.herr.text = lastSes.herramienta
            self.proxSes.text = self.elUsuario?.proximaSesion
            self.dateFormatter.dateStyle = DateFormatter.Style.long
            self.dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            self.ultSes.text = self.dateFormatter.string(from: lastSes.fecha)
            let convertedDate = self.dateFormatter.date(from: self.elUsuario?.proximaSesion ?? "")
            let now = Date()
            if ((convertedDate == nil || convertedDate! < now) && self.elUsuario?.status == 1) {
                self.status.image = UIImage(named: "amarillo")
            } else if (self.elUsuario?.status == 0) {
                self.status.image = UIImage(named: "rojo")
            } else {
                self.status.image = UIImage(named: "verde")
            }
        }
    }
    
    func botones(estado:Bool){
        if estado{
            editButton.isHidden = true
            saveButton.isHidden =  false
            cancelButton.isHidden =  false
            proxSes.isHidden = true
            pickProxSes.isHidden = false
            eliminarCita.isHidden = false
            edad.isUserInteractionEnabled = true
            sexo.isUserInteractionEnabled = true
        }
        else{
            editButton.isHidden = false
            saveButton.isHidden =  true
            cancelButton.isHidden =  true
            proxSes.isHidden = false
            pickProxSes.isHidden = true
            eliminarCita.isHidden = true
            edad.isUserInteractionEnabled = false
            sexo.isUserInteractionEnabled = false
        }
        
    }
    
    
    @IBAction func editarProxSesion(_ sender: UIButton) {
        editar = !editar
        botones(estado: editar)
    }
    
    @IBAction func cancelarEdicion(_ sender: UIButton) {
        editar = !editar
        botones(estado: editar)
    }
    @IBAction func guardarEdicion(_ sender: UIButton) {
        editar = !editar
        botones(estado: editar)
        self.dateFormatter.dateStyle = DateFormatter.Style.long
        self.dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let proxSesion = self.pickProxSes.date
        let convertedDate = self.dateFormatter.string(from: proxSesion)
        let error = validator.validateUpdateUser(edad: self.edad.text ?? "0", sexo: self.sexo.text ?? "")
        if error != nil {
            displayExito(title: error ?? "", detalle: "Hay datos incorrectos")
        } else {
            self.usuarioControlador.updateUsuario(usuarioId: self.elUsuario?.id ?? "", proxSes: convertedDate, edad: self.edad.text ?? "0", sexo: self.sexo.text ?? ""){ (result) in
                switch result{
                case .success(let retorno):
                    self.displayExito(title: retorno, detalle: "Se actualizó el registro")
                    self.proxSes.text = convertedDate
                    let now = Date()
                    if (proxSesion < now && self.elUsuario?.status == 1) {
                        self.status.image = UIImage(named: "amarillo")
                    } else if (self.elUsuario?.status == 0) {
                        self.status.image = UIImage(named: "rojo")
                    } else {
                        self.status.image = UIImage(named: "verde")
                    }
                case .failure(let error):self.displayError(error, title: "No se pudo modificar el registro")
                }
            }
        }
    }
    
    @IBAction func eliminarCita(_ sender: UIButton) {
        let alert = UIAlertController(title: "¿Eliminar la cita?", message: "El ususario no tendrá una cita programada.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { action in
            self.editar = !self.editar
            self.botones(estado: self.editar)
            self.usuarioControlador.updateProxSes(usuarioId: self.elUsuario?.id ?? "", proxSes: ""){ (result) in
                switch result{
                case .success(let retorno):
                    self.displayExito(title: retorno, detalle: "Se actualizó el registro")
                    self.proxSes.text = ""
                    if (self.elUsuario?.status == 1) {
                        self.status.image = UIImage(named: "amarillo")
                    } else {
                        self.status.image = UIImage(named: "rojo")
                    }
                    self.usuarioTable.tableView.reloadData()
                    self.usuarioTanTable.tableView.reloadData()
                case .failure(let error):self.displayError(error, title: "No se pudo modificar el registro")
                }
                
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "sesion" || segue.identifier == "sesion2") {
            let siguiente = segue.destination as! SesionesTableViewController
            self.embedvc = siguiente;
        }
    }
    
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
