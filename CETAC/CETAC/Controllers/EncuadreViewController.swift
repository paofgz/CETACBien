//
//  EncuadreViewController.swift
//  CETAC
//
//  Created by Annya Verduzco on 04/10/21.
//

import Foundation
import UIKit

class EncuadreViewController: UIViewController {

    var usuarioControlador = UsuarioController()
    var sesionControlador = SesionesController()
    var tanatologoControlador = TanatologoController()
    var validators = Validators()
    
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var fecha: UIDatePicker!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var ocupacion: UITextField!
    @IBOutlet weak var religion: UITextField!
    @IBOutlet weak var procedencia: UITextField!
    @IBOutlet weak var domicilio: UITextField!
    @IBOutlet weak var telCasa: UITextField!
    @IBOutlet weak var celular: UITextField!
    @IBOutlet weak var estadoCivil: estadoCivilPickerView!
    @IBOutlet weak var edadPareja: UITextField!
    @IBOutlet weak var sexoPareja: UITextField!
    @IBOutlet weak var hijos: UITextField!
    @IBOutlet weak var referido: UITextField!
    @IBOutlet weak var motivo: motivosPickerView!
    @IBOutlet weak var idRespuesta: UITextField!
    @IBOutlet weak var ekr: UITextField!
    @IBOutlet weak var serv: servicioPickerView!
    @IBOutlet weak var intervencion: intervencionPickerView!
    @IBOutlet weak var evaluacion: UITextField!
    @IBOutlet weak var cuotaRec: UITextField!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var proxSes: UIDatePicker!
    @IBOutlet weak var edad: UITextField!
    @IBOutlet weak var sexo: generoPickerView!
    
    func viewWillappear() {
        super.viewDidLoad()
        
        self.setupToHideKeyboardOnTapOnView()
        
        self.nombre.text = ""
        self.ocupacion.text = ""
        self.religion.text = ""
        self.procedencia.text = ""
        self.domicilio.text = ""
        self.telCasa.text = ""
        self.celular.text = ""
        self.edadPareja.text = ""
        self.sexoPareja.text = ""
        self.hijos.text = ""
        self.referido.text = ""
        self.idRespuesta.text = ""
        self.ekr.text = ""
        self.evaluacion.text = ""
        self.cuotaRec.text = ""
        self.edad.text = ""
                
        self.estadoCivil.delegate = estadoCivil
        self.estadoCivil.dataSource = estadoCivil
        
        self.motivo.delegate = motivo
        self.motivo.dataSource = motivo

        self.serv.delegate = serv
        self.serv.dataSource = serv

        self.intervencion.delegate = intervencion
        self.intervencion.dataSource = intervencion
        
        self.sexo.delegate = sexo
        self.sexo.dataSource = sexo
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupToHideKeyboardOnTapOnView()
                
        self.estadoCivil.delegate = estadoCivil
        self.estadoCivil.dataSource = estadoCivil
        
        self.motivo.delegate = motivo
        self.motivo.dataSource = motivo

        self.serv.delegate = serv
        self.serv.dataSource = serv

        self.intervencion.delegate = intervencion
        self.intervencion.dataSource = intervencion
        
        self.sexo.delegate = sexo
        self.sexo.dataSource = sexo
    }
    
    @IBAction func save(_ sender: UIButton) {
        if (self.nombre.text == "" || self.celular.text == "" || self.telCasa.text == "" || self.ocupacion.text == "" || self.religion.text == "" || self.procedencia.text == "" || self.domicilio.text == "" || (self.edadPareja.text != "" && self.sexoPareja.text == "" ) || (self.edadPareja.text == "" && self.sexoPareja.text != "" ) || self.referido.text == "" || self.idRespuesta.text == "" || self.ekr.text == "" || self.evaluacion.text == "" || self.cuotaRec.text == "" || self.edad.text == "") {
                    displayExito(title: "Información incompleta", detalle: "Se debe ingresar el nombre y al menos una forma de contacto")
                } else {
                    let error = validators.validateEncuadre(nombre: self.nombre.text ?? "", celular: self.celular.text ?? "", telefono:self.telCasa.text ?? "", edadPareja:self.edadPareja.text ?? "", sexoPareja:self.sexoPareja.text ?? "", referido:self.referido.text ?? "", cuotaRec:self.cuotaRec.text ?? "0", edad:self.edad.text ?? "0", hijos:self.hijos.text ?? "")
                    if error != nil {
                        displayError(error as! Error, title: "Hay datos incorrectos")
                    } else {
                        self.dateFormatter.dateStyle = DateFormatter.Style.long
                        self.dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                        let fecha = self.fecha.date
                        let proximaSesion = self.proxSes.date
                        let proximaSes = self.dateFormatter.string(from: proximaSesion)
                        let edoCivil = self.estadoCivil.getSelected(estadoCivil, selectedRow: self.estadoCivil.selectedRow(inComponent: 0)) ?? ""
                        let motivo = self.motivo.getSelected(motivo, selectedRow: self.motivo.selectedRow(inComponent: 0)) ?? ""
                        let sexo = self.sexo.getSelected(sexo, selectedRow: self.sexo.selectedRow(inComponent: 0)) ?? ""
                        let inter = self.intervencion.getSelected(intervencion, selectedRow: self.intervencion.selectedRow(inComponent: 0)) ?? ""
                        let servicio = self.serv.getSelected(serv, selectedRow: self.serv.selectedRow(inComponent: 0)) ?? ""
                        let edadP = Int(self.edadPareja.text ?? "0")
                        let ed = Int(self.edad.text ?? "0")
                        let cuota = Float(self.cuotaRec.text ?? "0")
                        let tanatId = correo
                        let newUser = Usuario(fecha: fecha, idTanatologo: tanatId, nombre: self.nombre.text!, ocupacion: self.ocupacion.text ?? "", religion: self.religion.text ?? "", procedencia: self.procedencia.text ?? "", domicilio: self.domicilio.text ?? "", telefonoDeCasa: self.telCasa.text ?? "", celular: self.celular.text ?? "", estadoCivil: edoCivil, edadPareja: edadP ?? 0 , sexoPareja: self.sexoPareja.text ?? "", hijos: self.hijos.text ?? "", referido: self.referido.text ?? "", motivo: motivo, identificacionDeRespuesta: self.idRespuesta.text ?? "", EKR: self.ekr.text ?? "", status: 1, proximaSesion: proximaSes, sexo: sexo, edad: ed ?? 0)
                        let alert = UIAlertController(title: "¿Guardar encuadre?", message: "Se guardarán los datos del paciente", preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "Si", style: .cancel, handler: { action in self.usuarioControlador.insertUsuario(nuevoUsuario: newUser, completion: { (result) in
                                switch result{
                                case .success(let retorno):
                                    let newSesion = Sesion(fecha: fecha, herramienta: "Encuadre", tipoDeIntervencion: inter, evaluacionSesion: self.evaluacion.text ?? "", servicio: servicio, cuotaDeRecuperacion: cuota ?? 0.0, cerrarExpediente: false)
                                    self.displayExito(title: "Se guardó el usuario con id: \(retorno)", detalle: "Se guardó el encuadre")
                                    self.sesionControlador.insertSesion(idUsuario: retorno, nuevaSesion: newSesion, completion: { (res) in
                                            switch res{
                                            case .success(_):
                                                print("Done")
                                            case .failure(let error):
                                                self.displayError(error, title: "No se pudo guardar el registro")
                                            }
                                        })
                                    self.displayExito(title: retorno, detalle: "Se guardó el encuadre")
                                    self.viewWillappear()
                                case .failure(let error):self.displayError(error, title: "No se pudo guardar el usuario")
                                }
                            })
                        }))
                        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))

                        self.present(alert, animated: true)
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

extension UIViewController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
