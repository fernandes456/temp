//
//  Util.swift
//  MarvelCOTests
//
//  Created by Geraldo Fernandes on 14/04/24.
//

import Foundation
@testable import MarvelCO

func makeHero(name: String, id: Int) -> (hero: Hero, json: [String: Any]) {
    let (thumbnail, thumbnailJson) = makeThumbnail()
    let hero = Hero(id: id, name: name, description: "A description", thumbnail: thumbnail)
    
    let heroJson = [
        "id": hero.id,
        "name": hero.name,
        "description": hero.description,
        "thumbnail": thumbnailJson
    ].compactMapValues { $0 }
    
    return (hero, heroJson)
}

func makeThumbnail() -> (thumnail: Thumbnail, json: [String: Any]) {
    let thumbnail = Thumbnail(path: "https://a-thumbnail-url.com", extension: "jpg")
    
    let thumbnailJson = [
        "path" : thumbnail.path,
        "extension": thumbnail.extension
    ]
    
    return (thumbnail, thumbnailJson)
}

func makeHeroesJSON(_ items: [[String: Any]]) -> Data {
    let json = ["data":
                    ["results" : items]]
    return try! JSONSerialization.data(withJSONObject: json)
}
