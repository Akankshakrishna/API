//
//  DetailsViewController.swift
//  API
//
//  Created by Akanksha.A on 08/07/22.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var profile_pic: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bday: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var nickname: UILabel!
    
    var name_: String = "",bday_ : String = "",occu_: [String] = [],status_ : String = "",nickname_: String = "", appearance_: [Int] = [],portrayed_ : String = "",category_: String = "", im_ = UIImage(), id_: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profile_pic.image = im_
        id.text = "ID: \(id_)"
        name.text = "Name: \(name_)"
        bday.text = "Birthday: \(bday_)"
        status.text = "Status: \(status_)"
        nickname.text = "NickName: \(nickname_)"
    }


}
