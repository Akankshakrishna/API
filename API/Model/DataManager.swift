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
    
    var delegate : DataManagerDelegate?
    
    func fetchData(){
        let urlString = "https://www.breakingbadapi.com/api/characters?limit=100"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            print("Hiiii")
            let task = session.dataTask(with: url) { data, response, error in
                print("Something")
                if error != nil {
                    print("error1 : \(error!)")
                    return
                }
                if let safeData = data {
                    print("Hellooooo")
                    if let dataa = self.parseJSON(safeData){
                        print("data we get is \(dataa)")
                        self.delegate?.didUpdateData(self, dataa: dataa)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ requestData: Data) -> DataModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([DataInUrl].self, from: requestData)
            let id = decodedData[0].char_id
            let name = decodedData[0].name
            let bday = decodedData[0].birthday
            let occu = decodedData[0].occupation
            let imageUrl = decodedData[0].img
            let status  = decodedData[0].status
            let nickname = decodedData[0].nickname
            let appearance = decodedData[0].appearance
            let portrayed = decodedData[0].portrayed
            let category = decodedData[0].category
            
            let image11 = getImage(urlString: imageUrl)
            
            let data_required = DataModel(id: id, name: name, bday: bday, occu: occu, im: image11, status: status, nickname: nickname, appearance: appearance, portrayed: portrayed, category: category)
            return data_required
        }
        catch{
            print("error2 is \(error)")
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

