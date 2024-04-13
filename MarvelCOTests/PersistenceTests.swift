//
//  PersistenceTests.swift
//  MarvelCOTests
//
//  Created by Geraldo Fernandes on 11/04/24.
//

import XCTest
@testable import MarvelCO

final class PersistenceTests: XCTestCase {

    private let repository = CoreDataRepository()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        repository.deleteAllFavoriteHeroes()
    }

    func test_persistence_isEmptyAtStart() throws {
        
        let exp = expectation(description: "Wait loading from db")
        repository.fetchFavorite { heroes in
            XCTAssertEqual(heroes.count, 0)
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 30.0)
    }
    
    func test_persistence_AddHeroToFavorite() {
        let (hero1, _) = makeHero(name: "Wilson", id: 1)
        let (hero2, _) = makeHero(name: "Zoe", id: 2)
        let exp = expectation(description: "Wait loading from db")
        
        repository.addToFavorite(hero: hero1)
        repository.addToFavorite(hero: hero2)
        
        repository.fetchFavorite { heroes in
            XCTAssertEqual(heroes.count, 2)
            XCTAssertEqual(heroes, [hero1, hero2])
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 30.0)
    }
    
    func test_persistence_RemoveHeroFromFavorite() {
        let (hero1, _) = makeHero(name: "Wilson", id: 1)
        let (hero2, _) = makeHero(name: "Zoe", id: 2)
        let exp = expectation(description: "Wait loading from db")
        
        repository.addToFavorite(hero: hero1)
        repository.addToFavorite(hero: hero2)
        
        repository.removeFromFavorite(hero: hero1)
        
        repository.fetchFavorite { heroes in
            XCTAssertEqual(heroes.count, 1)
            XCTAssertEqual(heroes, [hero2])
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 30.0)
    }
    
    // MARK: - Helpers
    private func makeHero(name: String, id: Int) -> (hero: Hero, json: [String: Any]) {
        let (thumbnail, thumbnailJson) = makeThumbnail()
        let hero = Hero(id: id, name: name, description: "A description", thumbnail: thumbnail)
        
        // [gfsf] explicar exatamente o que isso aqui faz
        let heroJson = [
            "id": hero.id,
            "name": hero.name,
            "description": hero.description,
            "thumbnail": thumbnailJson
        ].compactMapValues { $0 }
        
        return (hero, heroJson)
    }
    
    private func makeThumbnail() -> (thumnail: Thumbnail, json: [String: Any]) {
        let thumbnail = Thumbnail(path: "https://a-thumbnail-url.com", extension: "jpg")
        
        let thumbnailJson = [
            "path" : thumbnail.path,
            "extension": thumbnail.extension
        ]
        
        return (thumbnail, thumbnailJson)
    }
    
    private func makeHeroesJSON(_ items: [[String: Any]]) -> Data {
        let json = ["data":
                        ["results" : items]]
        return try! JSONSerialization.data(withJSONObject: json)
    }
}
