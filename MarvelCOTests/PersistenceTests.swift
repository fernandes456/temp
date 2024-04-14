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
    
    func test_persistence_AddAndCheckAllModelAttributes() {
        let (hero1, _) = makeHero(name: "Wilson", id: 1)
        let (hero2, _) = makeHero(name: "Zoe", id: 2)
        
        repository.addToFavorite(hero: hero1)
        repository.addToFavorite(hero: hero2)
        
        let heroToBeChecked = repository.findHero(with: hero1.id)!
        XCTAssertEqual(hero1.id, heroToBeChecked.id)
        XCTAssertEqual(hero1.name, heroToBeChecked.name)
        XCTAssertEqual(hero1.description, heroToBeChecked.description)
        XCTAssertEqual(hero1.thumbnail.path, heroToBeChecked.thumbnail.path)
        XCTAssertEqual(hero1.thumbnail.extension, heroToBeChecked.thumbnail.extension)
    }
    
    func test_persistence_CheckAllModelAttributesFromFetch() {
        let (hero1, _) = makeHero(name: "Wilson", id: 1)
        let exp = expectation(description: "Wait loading from db")
        
        repository.addToFavorite(hero: hero1)
        
        repository.fetchFavorite { heroes in
            let heroToBeChecked = heroes.first!
            XCTAssertEqual(hero1.id, heroToBeChecked.id)
            XCTAssertEqual(hero1.name, heroToBeChecked.name)
            XCTAssertEqual(hero1.description, heroToBeChecked.description)
            XCTAssertEqual(hero1.thumbnail.path, heroToBeChecked.thumbnail.path)
            XCTAssertEqual(hero1.thumbnail.extension, heroToBeChecked.thumbnail.extension)
            
            exp.fulfill()
        }

        wait(for: [exp], timeout: 3.0)
    }
    
    // MARK: - Helpers

}
