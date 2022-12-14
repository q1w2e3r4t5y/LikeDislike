//
//  ShowDataList.swift
//  DigitalBrainMediaTask
//
//  Created by Rana singh on 13/12/22.
//

import Foundation
import UIKit

protocol sandFavouriteData:AnyObject {
    func isFavourite(isFavouriteID:Int)
}

class DataListCell: UITableViewCell {
    @IBOutlet weak var dataImageView: DataImageView!
    @IBOutlet weak var tittle: UILabel!
    @IBOutlet weak var dataId: UILabel!
    @IBOutlet weak var checkUncheckImg: UIImageView!
    @IBOutlet weak var favouriteButtonObject: UIButton!
    weak var delegate: sandFavouriteData?
    
    override func awakeFromNib() {
       super.awakeFromNib()
    }
    @IBAction func favouriteButtonAction(_ sender: UIButton) {
     delegate?.isFavourite(isFavouriteID: favouriteButtonObject.tag)
    }
    func updateData(listData:DataContainer){
        self.tittle.text = listData.title
        self.dataId.text = String(listData.albumID)
        self.dataImageView.loadImage(fromURL: listData.url)
    }
}
