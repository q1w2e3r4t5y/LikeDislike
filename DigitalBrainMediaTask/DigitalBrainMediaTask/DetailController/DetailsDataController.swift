//
//  DetailsDataController.swift
//  DigitalBrainMediaTask
//
//  Created by Rana singh on 13/12/22.
//

import UIKit
protocol sendDataBackToMainScreen:AnyObject {
    func sendDataBackToMainScreen(idValue:Int)
}
class DetailsDataController: UIViewController {
    
    @IBOutlet weak var albumID: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var tittleLable: UILabel!
    @IBOutlet weak var checkAndUncheck: UIImageView!
    @IBOutlet weak var favouriteButtonObject: UIButton!
    weak var delegate: sendDataBackToMainScreen?
    var dataObject : DataContainer?
    var isFavouriteOnDetails : Bool?
    var indexId = Int()
    var isFromDetailVC:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.initialUISetUP()
        
    }
    
    func initialUISetUP(){
        if dataObject != nil {
            tittleLable.text = dataObject?.title
            if isFavouriteOnDetails ?? false {
                favouriteButtonObject.setTitle("DisLike", for: .normal)
                checkAndUncheck.image = UIImage(named: "check")
            } else {
                checkAndUncheck.image = UIImage(named: "uncheck")
                favouriteButtonObject.setTitle("Like", for: .normal)
            }
            guard let url = dataObject?.url else {return}
            DispatchQueue.global().async { [weak self] in
                if let imageData = try? Data(contentsOf: URL(string: url)!)
                {  if let image = UIImage(data: imageData){
                    DispatchQueue.main.async {
                        self?.mainImage.image = image
                    }
                 }
                }
            }
        }
       }
    
    @IBAction func favouriteButtonAction(_ sender: Any) {
        
        if isFavouriteOnDetails ?? false {
            isFavouriteOnDetails = false
            initialUISetUP()
            delegate?.sendDataBackToMainScreen(idValue:indexId)
        } else {
            isFavouriteOnDetails = true
            initialUISetUP()
            delegate?.sendDataBackToMainScreen(idValue:indexId)
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
//              if let id = indexId {
//                delegate?.sendDataBackToMainScreen(idValue:id, isFav: isFavouriteOnDetails ?? false)
//                 if isFavouriteOnDetails ?? false {
//                     isFavouriteOnDetails = false
//                     initialUISetUP()
//                  }
//               }
         
//        if isFavouriteOnDetails ?? false {
//            
//          } else {
//            let isValueFromVM = viewModel.getCalculatedData(isBool:isFromDetailVC)
//            if isValueFromVM {
//                isFavouriteOnDetails = isValueFromVM
//                initialUISetUP()
//            }
//        }
        

        
    }
}
