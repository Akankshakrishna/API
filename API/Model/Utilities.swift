//
//  Utilities.swift
//  API
//
//  Created by Akanksha.A on 08/07/22.
//

import Foundation
import UIKit

class Utilities{
    
    var names : [String] = [], finalData : [String] = [], images : [UIImage] = [], bdays : [String] = [], nickNames : [String] = [], statuses : [String] = [], id : [Int] = [], final_data :[DataModel] = [], pq = Int()
    
}

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
