//
//  DataImageView.swift
//  DigitalBrainMediaTask
//
//  Created by Rana singh on 13/12/22.
//


import Foundation
import UIKit

class DataImageView: UIImageView
{
    func loadImage(fromURL imageURL: String){
        DispatchQueue.global().async {
            [weak self] in
            if let imageData = try? Data(contentsOf: URL(string: imageURL)!){
                if let image = UIImage(data: imageData){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

