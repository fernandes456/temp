//
//  Models.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import Foundation

struct MarvelResponse: Codable {
//    let code: Int
//    let status: String
//    let copyright: String
//    let attributionText: String
//    let attributionHTML: String
//    let etag: String
    let data: MarvelData
}

struct MarvelData: Codable {
//    let offset: Int
//    let limit: Int
//    let total: Int
//    let count: Int
    let results: [Hero]
}

struct Hero: Codable, Equatable {
    let id: Int
    let name: String
    let description: String
//    let modified: String
    let thumbnail: Thumbnail
//    let resourceURI: String
    
    static func == (lhs: Hero, rhs: Hero) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
    
    var urlString: String {
        "\(self.path)\(self.extension)"
    }
}
