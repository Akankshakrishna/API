//
//  ViewController.swift
//  API
//
//  Created by Akanksha.A on 07/07/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var namesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namesTable.delegate = self
        namesTable.dataSource = self
    }
    
    


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = namesTable.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        //cell.textLabel?.text =
        return UITableViewCell()
    }
    
    
}
