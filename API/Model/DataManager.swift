//
//  DataManager.swift
//  API
//
//  Created by Akanksha.A on 07/07/22.
//

import Foundation
import UIKit

protocol DataManagerDelegate{
    func didUpdateData(_ dataManager: DataManager, dataa: [DataModel])
}

class DataManager{
    
    var delegate : DataManagerDelegate?
    
    func fetchData(){
        let urlString = "https://www.breakingbadapi.com/api/characters?limit=100"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
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
    
    func parseJSON(_ requestData: Data) -> [DataModel]? {
        let decoder = JSONDecoder()
        var data_need = [DataModel]()
        do {
            let decodedData = try decoder.decode([DataInUrl].self, from: requestData)
            
            for i in 0...decodedData.count - 1 {
                
                let id = decodedData[i].char_id, name = decodedData[i].name, bday = decodedData[i].birthday, occu = decodedData[i].occupation, imageUrl = decodedData[i].img, status  = decodedData[i].status, nickname = decodedData[i].nickname, appearance = decodedData[i].appearance, portrayed = decodedData[i].portrayed, category = decodedData[i].category
                
                let image11 = getImage(urlString: imageUrl)
                
                let data_required = DataModel(id: id, name: name, bday: bday, occu: occu, im: image11, status: status, nickname: nickname, appearance: appearance, portrayed: portrayed, category: category)
                            
                data_need.append(data_required)
            }
            return data_need
//
        }
        catch{
            return nil
        }
    }
    
    func getImage(urlString: String) -> UIImage {
        var image22 = UIImage()
        let url = URL(string: urlString)
        if let data = try? Data(contentsOf: url!)
        {
            image22 = UIImage(data: data)!
        }
        return image22
    }
}

