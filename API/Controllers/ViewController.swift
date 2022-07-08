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
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = namesTable.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1). \(names[indexPath.row])"
        return cell
    }
    
}

