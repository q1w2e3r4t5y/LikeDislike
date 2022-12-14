//
//  DetailsViewModel.swift
//  DigitalBrainMediaTask
//
//  Created by Rana singh on 13/12/22.
//

import Foundation

class SelectedViewModel {
    
    var checkedData = [DataContainer]()
    func getCalculatedData(DataArray:[DataContainer], seletedIndexArray:[Int]){
        for obj in seletedIndexArray {
            let data = DataArray[obj]
            checkedData.append(data)
        }
    }
}
