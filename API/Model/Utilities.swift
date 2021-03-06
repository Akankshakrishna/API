//
//  Utilities.swift
//  API
//
//  Created by Akanksha.A on 08/07/22.
//

import Foundation
import UIKit
class Utilities {
    var names: [String] = []
    var allNames: [String] = []
    var finalData: [DataInUrl] = []
    var index = [Int]()
    func getImage(urlString: String) -> UIImage {
        var image22 = UIImage()
        let url = URL(string: urlString)
        if let data = try? Data(contentsOf: url!) {
            image22 = UIImage(data: data)!
        }
        return image22
    }
    func getOnlyNames(_ dataa: [DataInUrl]) {
        names = dataa.map { $0.name ?? "" }
        allNames = names
        finalData = dataa
    }
    func compareWithSearchName(indexPath: Int) {
        index = finalData.enumerated().filter({ $0.element.name == allNames[indexPath]}).map({ $0.offset })
    }
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
