//
//  SeguimientoViewController.swift
//  CETAC
//
//  Created by Annya Verduzco on 05/10/21.
//

import UIKit

class SeguimientoViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var usuarioControlador = UsuarioController()
    var sesionControlador = SesionesController()
    var validators = Validators()
    
    let dateFormatter = DateFormatter()
    
    
    @IBOutlet weak var FechaSelect: UIDatePicker!
   
    
    @IBOutlet weak var IntervencionSeg: intervencionPickerView!
    @IBOutlet weak var HerramientaSeg: herramientasPickerView!
    @IBOutlet weak var servicioSeg: servicioPickerView!
    @IBOutlet weak var evaluacionSes: UITextField!
    @IBOutlet weak var cuotaRe: UITextField!
    @IBOutlet weak var action: UISwitch!
    @IBOutlet weak var usuariosPV: UIPickerView!
   
    var usuarios = [Usuario]()
    
    func viewWillappear(){
        
        super.viewDidLoad()
        
        usuarioControlador.fetchUsuariosByTan(idTan: correo){ (result) in
            switch result{
            case .success(let usuarios):self.setUsuarioViewer(with: usuarios)
            case .failure(let error):print("No se pudo acceder a los usuarios, Error: \(error)")
            }
        }
    self.setupToHideKeyboardOnTapOnView()
   
    self.evaluacionSes.text = ""
    self.cuotaRe.text = ""
  
 
    self.IntervencionSeg.delegate = IntervencionSeg
    self.IntervencionSeg.dataSource = IntervencionSeg
        
    self.HerramientaSeg.delegate = HerramientaSeg
    self.HerramientaSeg.dataSource = HerramientaSeg
        
    self.servicioSeg.delegate = servicioSeg
    self.servicioSeg.dataSource = servicioSeg
}

    override func viewDidLoad() {
        super.viewDidLoad()
        usuarioControlador.fetchUsuariosByTan(idTan: correo){ (result) in
        switch result{
        case .success(let usuarios):self.setUsuarioViewer(with: usuarios)
        case .failure(let error):print("No se pudo acceder a los usuarios, Error: \(error)")
        }
    }
    
        
    self.setupToHideKeyboardOnTapOnView()
 
    self.IntervencionSeg.delegate = IntervencionSeg
    self.IntervencionSeg.dataSource = IntervencionSeg
        
    self.HerramientaSeg.delegate = HerramientaSeg
    self.HerramientaSeg.dataSource = HerramientaSeg
        
    self.servicioSeg.delegate = servicioSeg
    self.servicioSeg.dataSource = servicioSeg
}

    
    @IBAction func guardar(_ sender: UIButton) {
        if (self.evaluacionSes.text == "") {
            displayExito(title: "Información incompleta", detalle: "Se debe ingresar la evaluación de la sesión")
        } else {
            let error = validators.validateSesion(cuotaRec: self.cuotaRe.text ?? "0")
            if error != nil {
                displayExito(title: error ?? "", detalle: "Hay datos incorrectos")
            } else {
                self.dateFormatter.dateStyle = DateFormatter.Style.long
                self.dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                let fecha = self.FechaSelect.date
                let cuota = Float(self.cuotaRe.text ?? "0")
                let inter = self.IntervencionSeg.getSelected(IntervencionSeg, selectedRow: self.IntervencionSeg.selectedRow(inComponent: 0)) ?? ""
                let herramienta = self.HerramientaSeg.getSelected(HerramientaSeg, selectedRow: self.HerramientaSeg.selectedRow(inComponent: 0)) ?? ""
                let servicio = self.servicioSeg.getSelected(servicioSeg, selectedRow: self.servicioSeg.selectedRow(inComponent: 0)) ?? ""
                let switchCase = action.isOn
                let usuarioId = self.getSelected(usuariosPV, selectedRow: self.usuariosPV.selectedRow(inComponent: 0)) ?? ""
                let newSesion = Sesion(fecha: fecha, herramienta: herramienta, tipoDeIntervencion: inter, evaluacionSesion: self.evaluacionSes.text ?? "", servicio: servicio, cuotaDeRecuperacion: cuota ?? 0.0, cerrarExpediente: switchCase)
                let numSes = self.getNumSes(usuariosPV, selectedRow: self.usuariosPV.selectedRow(inComponent: 0)) ?? 0
                                      
                let alert = UIAlertController(title: "¿Guardar hoja de seguimiento?", message: "Se guardarán los datos del seguimiento", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Si", style: .cancel, handler: { action in self.sesionControlador.insertSesion(idUsuario: usuarioId , nuevaSesion: newSesion, completion:{ (result) in
                    switch result {
                    case .success(let retorno):
                        var status = 1
                        if switchCase == true {
                            status = 0
                        } else {
                            status = 1
                        }
                        self.usuarioControlador.updateUser(usuarioId: usuarioId, status: status, numSes: numSes+1, lastSes: fecha, completion: { (result) in
                                switch result {
                                case .success(_):
                                    print("Se actualizó el usuario")
                                case .failure(let error): self.displayError(error, title:"No se pudo actualizar el usuario")
                                }
                        })
                            self.displayExito(title: "Se guardó la sesión con id: \(retorno)", detalle: "Se guardó la sesión")
                            self.viewWillappear()
                    case .failure(let error):self.displayError(error, title: "No se pudo guardar la sesión")
                        }
                    })
                }))
                alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))

                self.present(alert, animated: true)
            }
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return usuarios.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return usuarios[row].nombre
        }
        
        func setUsuarioViewer(with: [Usuario]) {
            self.usuarios = with
            self.usuariosPV.delegate = self
            self.usuariosPV.dataSource = self
        }
        
        func getSelected(_ pickerView: UIPickerView, selectedRow row: Int) -> String? {
            return usuarios[row].id
        }
    
        func  getNumSes(_ pickerView: UIPickerView, selectedRow row: Int) -> Int? {
            return usuarios[row].numSes
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
                func SetupToHideKeyboardOnTapOnView()
            {
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(
                    target: self,
                    action: #selector(UIViewController.dismissKeyboard))

                tap.cancelsTouchesInView = false
                view.addGestureRecognizer(tap)
            }

            @objc func DismissKeyboard()
            {
                view.endEditing(true)
            }
        }
