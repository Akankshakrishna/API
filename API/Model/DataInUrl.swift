//
//  DataInUrl.swift
//  API
//
//  Created by Akanksha.A on 07/07/22.
//

import Foundation
import UIKit

struct DataInUrl : Codable{
    
    let char_id: Int
    let name: String
    let birthday : String
    let occupation: [String]
    let imgUrl : String
    let status : String
    let nickname: String
    let appearance: [Int]
    let portrayed : String
    let category: String
   // let better_call_saul_appearance: [String]?
    
}
