//
//  DataViewModel.swift
//  DigitalBrainMediaTask
//
//  Created by Rana singh on 13/12/22.
//

import Foundation


class DataViewModel {

    var listOfData = [DataContainer]()
    var selectedLikeData = [Int]()
    func getDataList(albumId : Int, completion : @escaping () -> ()) {
        let sourcesURL = URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)")!
        URLSession.shared.dataTask(with: sourcesURL) { [weak self] (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let empData = try! jsonDecoder.decode([DataContainer].self, from: data)
                self?.listOfData = empData
                completion()
            }
        }.resume()
    }
    func checkUncheckDataUpdate(checkDataArray: inout [Int], intValue:Int){
        if  let id =  checkDataArray.firstIndex(of: intValue) {
            checkDataArray.remove(at: id)
        } else {
            checkDataArray.append(intValue)
        }
       selectedLikeData = checkDataArray
    }
    
    
}
