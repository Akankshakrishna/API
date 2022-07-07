//
//  DataManager.swift
//  API
//
//  Created by Akanksha.A on 07/07/22.
//

import Foundation
import UIKit

protocol DataManagerDelegate{
    func didUpdateData(_ dataManager: DataManager, dataa: DataModel)
}

class DataManager{
    
    let urlString = "https://www.breakingbadapi.com/api/characters?limit=100"
    
    var delegate : DataManagerDelegate?
    
    func fetchData(){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let dataa = self.parseJSON(safeData){
                        print(dataa)
                        self.delegate?.didUpdateData(self, dataa: dataa)
                    }
                }
            }
            
        }
        
    }
    
    func parseJSON(_ requestData: Data) -> DataModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DataInUrl.self, from: requestData)
            let id = decodedData.char_id
            let name = decodedData.name
            let bday = decodedData.birthday
            let occu = decodedData.occupation
            let imageUrl = decodedData.imgUrl
            let status  = decodedData.status
            let nickname = decodedData.nickname
            let appearance = decodedData.appearance
            let portrayed = decodedData.portrayed
            let category = decodedData.category
            
            let image11 = getImage(urlString: imageUrl)
            
            let data_required = DataModel(id: id, name: name, bday: bday, occu: occu, im: image11, status: status, nickname: nickname, appearance: appearance, portrayed: portrayed, category: category)
            return data_required
        }
        catch{
            print(error)
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

