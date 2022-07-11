//
//  ViewController.swift
//  API
//
//  Created by Akanksha.A on 07/07/22.
//

import UIKit

class ViewController: UIViewController, DataManagerDelegate {
    
    let utilities = Utilities()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var namesTable: UITableView!
    
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namesTable.rowHeight = 50.0
        namesTable.separatorStyle = .none
        dataManager.delegate = self
        dataManager.fetchData()
    }
    
    
    func didUpdateData(_ dataManager: DataManager, dataa: [DataInUrl]) {
        for everyData in dataa{
            utilities.names.append(everyData.name)
        }
        utilities.finalData = utilities.names
        utilities.final_data = dataa
        DispatchQueue.main.async {
            self.namesTable.reloadData()
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return utilities.finalData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = namesTable.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        cell.textLabel?.text = "\(utilities.finalData[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        for i in 0...utilities.final_data.count - 1 {
            if utilities.finalData[indexPath.row] == utilities.final_data[i].name {
                utilities.pq = i
                break
            }
        }
        vc.retrivedData = utilities.final_data[utilities.pq]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UISearchBarDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        utilities.finalData = searchText.isEmpty ? utilities.names : utilities.names.filter({ $0.contains(searchText)})
            namesTable.reloadData()
    }
}
