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
    
    func fetchData(indexOfArray: Int){
        let urlString = "https://www.breakingbadapi.com/api/characters?limit=100"
        performRequest(with: urlString, indexOfAr: indexOfArray)
    }
    
    func performRequest(with urlString: String, indexOfAr : Int){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
         //   print("Hiiii")
            let task = session.dataTask(with: url) { data, response, error in
               // print("Something")
                if error != nil {
                    //print("error1 : \(error!)")
                    return
                }
                if let safeData = data {
                   // print("Hellooooo")
                    if let dataa = self.parseJSON(safeData, indexOfArray: indexOfAr){
                       // print("data we get is \(dataa)")
                        self.delegate?.didUpdateData(self, dataa: dataa)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ requestData: Data, indexOfArray : Int) -> DataModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([DataInUrl].self, from: requestData)
            let id = decodedData[indexOfArray].char_id
            let name = decodedData[indexOfArray].name
            let bday = decodedData[indexOfArray].birthday
            let occu = decodedData[indexOfArray].occupation
            let imageUrl = decodedData[indexOfArray].img
            let status  = decodedData[indexOfArray].status
            let nickname = decodedData[indexOfArray].nickname
            let appearance = decodedData[indexOfArray].appearance
            let portrayed = decodedData[indexOfArray].portrayed
            let category = decodedData[indexOfArray].category
            
            let image11 = getImage(urlString: imageUrl)
            
            let data_required = DataModel(id: id, name: name, bday: bday, occu: occu, im: image11, status: status, nickname: nickname, appearance: appearance, portrayed: portrayed, category: category)
            return data_required
        }
        catch{
           // print("error2 is \(error)")
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

