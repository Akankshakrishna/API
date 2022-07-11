//
//  DataManager.swift
//  API
//
//  Created by Akanksha.A on 07/07/22.
//

import Foundation
import UIKit
protocol DataManagerDelegate {
    func didUpdateData(_ dataManager: DataManager, dataa: [DataInUrl])
}
class DataManager {
    var delegate: DataManagerDelegate?
    func fetchData() {
        let urlString = "https://www.breakingbadapi.com/api/characters?limit=100"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    return
                }
                if let safeData = data {
                    let dataa = self.parseJSON(safeData)
                    self.delegate?.didUpdateData(self, dataa: dataa!)
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ requestData: Data) -> [DataInUrl]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([DataInUrl].self, from: requestData)
            return decodedData
        } catch {
            return nil
        }
    }
}
