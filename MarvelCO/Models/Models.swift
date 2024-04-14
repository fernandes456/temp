//
//  Models.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import Foundation

struct MarvelResponse: Codable {
    let data: MarvelData
}

struct MarvelData: Codable {
    let results: [Hero]
}

struct Hero: Codable, Equatable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    
    static func == (lhs: Hero, rhs: Hero) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
    
    var urlString: String {
        "\(self.path).\(self.extension)"
    }
}
