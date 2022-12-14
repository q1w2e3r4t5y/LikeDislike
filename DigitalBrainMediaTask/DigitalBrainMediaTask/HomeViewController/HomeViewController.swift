//
//  ViewController.swift
//  DigitalBrainMediaTask
//
//  Created by Rana singh on 13/12/22.
//

import UIKit
class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBarObj: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBarDataObject: UIButton!
    @IBOutlet weak var tabBarSelectedData: UIButton!
    var dataViewModel = DataViewModel()
    var dataList = [DataContainer]()
    var selectedLikeIndex = [Int]()
    let maxCellLimit = 50
    var albumId = 0
    var isFavourite = false
    var indexValue:Int?
    var filteredData: [DataContainer]!
    var isSearching = false
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataFromViewModel()
        searchBarObj.delegate = self
    }
    @IBAction func tabbarAction(_ sender: UIButton) {
        let selectDataVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectedDataController") as! SelectedDataController
            selectDataVC.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 60)
        if sender == tabBarDataObject {
            self.removeTopChildViewController()
        } else {
            selectDataVC.checkedData = selectedLikeIndex
            selectDataVC.allData = dataList
            addChild(selectDataVC)
            view.addSubview(selectDataVC.view)
            selectDataVC.didMove(toParent: self)
        }
    }
    func removeTopChildViewController(){
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            viewControllers.last?.willMove(toParent: nil)
            viewControllers.last?.removeFromParent()
            viewControllers.last?.view.removeFromSuperview()
        }
    }
    func reloadTableView(){
        DispatchQueue.main.async {
            if let id = self.indexValue {
                let indexPath = IndexPath(row: id, section: 0)
                self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
            }
        }
    }
    func getDataFromViewModel(){
        albumId = albumId + 1
        dataViewModel.getDataList(albumId:albumId) { [weak self] in
            if let data = self?.dataViewModel.listOfData {
                if ((self?.dataList.isEmpty) != nil) {
                    self?.dataList += data
                } else {
                    self?.dataList = data
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self?.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController:sandFavouriteData,sendDataBackToMainScreen {
     func sendDataBackToMainScreen(idValue: Int) {
         isFavourite(isFavouriteID:idValue)
     }
    func isFavourite(isFavouriteID:Int) {
        self.indexValue = isFavouriteID
        dataViewModel.checkUncheckDataUpdate(checkDataArray: &selectedLikeIndex, intValue: isFavouriteID)
        self.selectedLikeIndex = dataViewModel.selectedLikeData
        self.reloadTableView()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredData.count
        } else {
            return dataList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataListCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.favouriteButtonObject.tag = indexPath.row
        if isSearching {
            cell.updateData(listData: filteredData[indexPath.row])
            if selectedLikeIndex.contains(indexPath.row){
                cell.checkUncheckImg.image = UIImage(named: "check")
                cell.favouriteButtonObject.setTitle("DisLike", for: .normal)
            } else {
                cell.checkUncheckImg.image = UIImage(named: "uncheck")
                cell.favouriteButtonObject.setTitle("Like", for: .normal)
            }
        }else {
            cell.updateData(listData: dataList[indexPath.row])
            if selectedLikeIndex.contains(indexPath.row){
                cell.checkUncheckImg.image = UIImage(named: "check")
                cell.favouriteButtonObject.setTitle("DisLike", for: .normal)
            } else {
                cell.checkUncheckImg.image = UIImage(named: "uncheck")
                cell.favouriteButtonObject.setTitle("Like", for: .normal)
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailsDataController") as! DetailsDataController
        detailVC.delegate = self
        detailVC.dataObject = dataList[indexPath.row]
        if let idValue =  selectedLikeIndex.firstIndex(of: indexPath.row){
            detailVC.indexId = idValue
        } else {
            detailVC.indexId = indexPath.row
        }
        if selectedLikeIndex.contains(indexPath.row){
            detailVC.isFavouriteOnDetails = true
        } else {
            detailVC.isFavouriteOnDetails = false
        }
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataList.count - 1 {
            if albumId < 11 {
                self.getDataFromViewModel()
            }
        }
    }
}
extension HomeViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = dataList.filter({$0.title.lowercased().prefix(searchText.count) == searchText.lowercased()})
        isSearching = true
        tableView.reloadData()
    }
}
