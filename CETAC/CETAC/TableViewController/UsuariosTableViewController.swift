//
//  UsuariosTableViewController.swift
//  CETAC
//
//  Created by Paola Fernández on 30/09/21.
//

import UIKit
var colors = Colors()
var color1 = colors.hexStringToUIColor(hex:"#2CABEA")

struct Section {
    let letter : String
    let users : [Usuario]
}


class UsuariosTableViewController: UITableViewController {

    var usuarioControlador = UsuarioController()
    var datos = [Usuario]()
    var sections = [Section]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usuarioControlador.fetchUsuarios{ (result) in
            switch result{
            case .success(let usuarios):self.updateUI(with: usuarios)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a los usuarios")
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.rowHeight =  80.0
        tableView.estimatedRowHeight = 80.0
        usuarioControlador.fetchUsuarios{ (result) in
            switch result{
            case .success(let usuarios):self.updateUI(with: usuarios)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a los usuarios")
            }
            
        }
    }
    
    func updateUI(with usuarios:Usuarios){
        let groupedDictionary = Dictionary(grouping: usuarios, by: {String($0.nombre.prefix(1))})
        let keys = groupedDictionary.keys.sorted()
            // map the sorted keys to a struct
        sections = keys.map{ Section(letter: $0, users: groupedDictionary[$0]!) }
        DispatchQueue.main.async {
            self.datos = usuarios
            self.tableView.reloadData()
        }
    }
    
    func updateUI(){
        
        usuarioControlador.fetchUsuarios{ (result) in
            switch result{
            case .success(let usuarios):self.updateUI(with: usuarios)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a los usuarios")
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
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].users.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map{$0.letter}
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = color1
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath) as! UsuarioTableViewCell
        let section = sections[indexPath.section]
        // Configure the cell...
//        cell.textLabel?.text = datos[indexPath.row].nombre
        cell.update(with: section.users[indexPath.row])


        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detalle"{
            let siguiente = segue.destination as! DetalleUsuarioViewController
            let section = self.tableView.indexPathForSelectedRow?.section
            let indice = self.tableView.indexPathForSelectedRow?.row
            siguiente.elUsuario = sections[section!].users[indice!]
        }
    }
}
