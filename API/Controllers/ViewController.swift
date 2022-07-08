//
//  ViewController.swift
//  API
//
//  Created by Akanksha.A on 07/07/22.
//

import UIKit

class ViewController: UIViewController, DataManagerDelegate {
    
    var names : [String] = []
    var searchNames : [String] = []
    var searchActive : Bool = false
    var final_data :[DataModel] = []

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var namesTable: UITableView!
    
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        print("start")
        dataManager.fetchData()
    }
    
    
    func didUpdateData(_ dataManager: DataManager, dataa: [DataModel]) {
        
        for i in 0...61{
            names.append(dataa[i].name)
        }
        
        final_data = dataa
    
        DispatchQueue.main.async {
            self.namesTable.reloadData()
        }
    }
    
    func getDetails(dataa: [DataModel], i: Int) -> DataModel {
        
        let id = dataa[i].id
        let name = dataa[i].name
        let bday = dataa[i].bday
        let occu = dataa[i].occu
        let status  = dataa[i].status
        let nickname = dataa[i].nickname
        let appearance = dataa[i].appearance
        let portrayed = dataa[i].portrayed
        let category = dataa[i].category
        let im = dataa[i].im
        
        let data_required = DataModel(id: id, name: name, bday: bday, occu: occu, im: im, status: status, nickname: nickname, appearance: appearance, portrayed: portrayed, category: category)
                    
        return data_required
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
                    return searchNames.count
                }
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = namesTable.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        //cell.textLabel?.text = "\(indexPath.row + 1). \(names[indexPath.row])"
        if(searchActive){
            cell.textLabel?.text = "\(indexPath.row + 1). \(searchNames[indexPath.row])"
        }
        else{
            cell.textLabel?.text = "\(indexPath.row + 1). \(names[indexPath.row])"
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailsViewController
        
        if let indexPath = namesTable.indexPathForSelectedRow{
            let r_data = getDetails(dataa: final_data, i: indexPath.row)
            vc.name_ = r_data.name; vc.id_ = r_data.id; vc.bday_ = r_data.bday; vc.status_ = r_data.status; vc.nickname_ = r_data.nickname; vc.im_ = r_data.im
        }
    }
    
}

extension ViewController: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchActive = true
        }
       
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchActive = false
        }
       
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false
        }
       
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchNames = names.compactMap({ $0 }).filter ({$0.lowercased().contains(searchText.lowercased())})
        
        if(searchNames.count == 0){
            searchActive = false
        }
        else {
            searchActive = true
        }
        namesTable.reloadData()
    }
}
