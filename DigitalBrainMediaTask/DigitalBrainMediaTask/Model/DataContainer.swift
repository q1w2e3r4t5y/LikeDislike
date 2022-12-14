//
//  DataContainer.swift
//  DigitalBrainMediaTask
//
//  Created by Rana singh on 13/12/22.
//

import Foundation

struct DataContainer: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

//typealias Welcome = [DataContainer]
