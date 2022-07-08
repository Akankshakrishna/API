//
//  ViewController.swift
//  API
//
//  Created by Akanksha.A on 07/07/22.
//

import UIKit

class ViewController: UIViewController, DataManagerDelegate {
    
//    var name: String = "",bday : String = "",occu: [String] = [],status : String = "",nickname: String = "", appearance: [Int] = [],portrayed : String = "",category: String = "", im = UIImage(), id: Int = 0
    var names : [String] = []
    var searchNames : [String] = []
    var searchActive : Bool = false

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
//        name = dataa.name; id = dataa.id; bday = dataa.bday; occu = dataa.occu; status = dataa.status; nickname = dataa.nickname; appearance = dataa.appearance; portrayed = dataa.portrayed; category = dataa.category; im = dataa.im
        
        for i in 0...61{
            names.append(dataa[i].name)
        }
    
        DispatchQueue.main.async {
            self.namesTable.reloadData()
        }
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
