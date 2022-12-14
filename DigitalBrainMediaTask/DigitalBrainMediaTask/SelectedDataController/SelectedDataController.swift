//
//  SelectedDataController.swift
//  DigitalBrainMediaTask
//
//  Created by Rana singh on 13/12/22.
//

import UIKit

class SelectedDataController: UIViewController {
    
      let selectedVM = SelectedViewModel()
      var allData = [DataContainer]()
      var checkedData = [Int]()
      var newData = [DataContainer]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedVM.getCalculatedData(DataArray: allData, seletedIndexArray: checkedData)
        newData = selectedVM.checkedData
    }
}

extension SelectedDataController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return newData.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedDataController", for: indexPath) as! DataListCell
            cell.selectionStyle = .none
            cell.tittle.text = newData[indexPath.row].title
            cell.dataId.text = String(newData[indexPath.row].albumID)
            cell.dataImageView.loadImage(fromURL: newData[indexPath.row].url)
            cell.checkUncheckImg.image = UIImage(named: "check")
          
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
