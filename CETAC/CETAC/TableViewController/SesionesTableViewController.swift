//
//  SesionesTableViewController.swift
//  CETAC
//
//  Created by Paola Fernández on 15/10/21.
//

//
//  UsuariosTableViewController.swift
//  CETAC
//
//  Created by Paola Fernández on 30/09/21.
//

import UIKit

class SesionesTableViewController: UITableViewController {

    var sesionesControlador = SesionesController()
    var datos = [Sesion]()
    var idUsuario: String = "0"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sesionesControlador.fetchSesiones(idUsuario){ (result) in
            switch result{
            case .success(let sesiones):self.updateUI(with: sesiones)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a las sesiones")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.rowHeight =  70.0
        tableView.estimatedRowHeight = 70.0
        sesionesControlador.fetchSesiones(idUsuario){ (result) in
            switch result{
            case .success(let sesiones):self.updateUI(with: sesiones)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a las sesiones")
            }
    }
    }
    
    func updateUI(with sesiones:Sesiones){
        DispatchQueue.main.async {
            self.datos = sesiones
            self.tableView.reloadData()
        }
    }
    
    func updateUI(){
        sesionesControlador.fetchSesiones(idUsuario){ (result) in
            switch result{
            case .success(let sesiones):self.updateUI(with: sesiones)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a las sesiones")
            }
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
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SesionTableViewCell
        // Configure the cell...
//        cell.textLabel?.text = datos[indexPath.row].nombre
        cell.update(with: datos[indexPath.row], index: indexPath.row)
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detalle"{
            let siguiente = segue.destination as! DetalleUsuarioViewController
            let section = self.tableView.indexPathForSelectedRow?.section
            let indice = self.tableView.indexPathForSelectedRow?.row
            siguiente.elUsuario = sections[section!].users[indice!]
        }
    }*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detalleSes"{
            let siguiente = segue.destination as! SesionDetalleViewController
            let indice = self.tableView.indexPathForSelectedRow?.row
            siguiente.laSesion = datos[indice!]
            siguiente.idUsuario = self.idUsuario
            siguiente.ind = indice
        }
        if segue.identifier == "detalleSesAdmin"{
            let siguiente = segue.destination as! SesionDetalleAdminViewController
            let indice = self.tableView.indexPathForSelectedRow?.row
            siguiente.laSesion = datos[indice!]
            siguiente.idUsuario = self.idUsuario
            siguiente.ind = indice
        }
    }
}
