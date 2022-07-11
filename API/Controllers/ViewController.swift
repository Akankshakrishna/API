//
//  ViewController.swift
//  API
//
//  Created by Akanksha.A on 07/07/22.
//

import UIKit
class ViewController: UIViewController, DataManagerDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var namesTable: UITableView!
    let dataManager = DataManager()
    let utilities = Utilities()
    override func viewDidLoad() {
        super.viewDidLoad()
        namesTable.rowHeight = 50.0
        namesTable.separatorStyle = .none
        dataManager.delegate = self
        dataManager.fetchData()
    }
    func didUpdateData(_ dataManager: DataManager, dataa: [DataInUrl]) {
        utilities.names = dataa.map { $0.name ?? "" }
        utilities.allNames = utilities.names
        utilities.finalData = dataa
        DispatchQueue.main.async {
            self.namesTable.reloadData()
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return utilities.allNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = namesTable.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        cell.textLabel?.text = "\(utilities.allNames[indexPath.row])"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        for index in 0...utilities.finalData.count - 1 {
            if utilities.allNames[indexPath.row] == utilities.finalData[index].name {
                utilities.index = index
                break
            }
        }
        secondVc?.retrivedData = utilities.finalData[utilities.index]
        self.navigationController?.pushViewController(secondVc!, animated: true)
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        utilities.allNames = searchText.isEmpty ? utilities.names : utilities.names.filter({ $0.range(of: searchText, options: .caseInsensitive) != nil })
            namesTable.reloadData()
    }
}
