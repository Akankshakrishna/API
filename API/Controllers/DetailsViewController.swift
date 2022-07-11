//
//  DetailsViewController.swift
//  API
//
//  Created by Akanksha.A on 08/07/22.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bday: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var nickname: UILabel!
   let utilities = Utilities()
   var retrivedData = DataInUrl(char_id: 0, name: "", birthday: "", occupation: [], img: "", status: "", nickname: "", appearance: [], portrayed: "", category: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.image = utilities.getImage(urlString: retrivedData.img!)
        id.text = "ID: \(String(describing: retrivedData.char_id!))"
        name.text = "Name: \(String(describing: retrivedData.name!))"
        bday.text = "Birthday: \(String(describing: retrivedData.birthday!))"
        status.text = "Status: \(String(describing: retrivedData.status!))"
        nickname.text = "NickName: \(String(describing: retrivedData.nickname!))"
    }
}
