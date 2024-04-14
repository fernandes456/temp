//
//  ViewModelTests.swift
//  MarvelCOTests
//
//  Created by Geraldo Fernandes on 14/04/24.
//

import XCTest
@testable import MarvelCO

final class ViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_viewModel_OnEmptyList() {
        let (sut, _) = makeSUT()
        let exp = expectation(description: "Wait for response")
        
        sut.showErrorView = { message in
            XCTAssertEqual(message, "Lista vazia")
            exp.fulfill()
        }
        
        sut.reloadCollectionViewClosure = {
            XCTFail("Try to load in error")
            exp.fulfill()
        }
        
        sut.fetchHeroes()
        
        wait(for: [exp], timeout: 2.0)
    }

    func test_viewModel_OnError() {
        let (sut, repository) = makeSUT()
        let exp = expectation(description: "Wait for response")
        
        sut.showErrorView = { message in
            XCTAssertEqual(message, "Ocorreu um erro")
            exp.fulfill()
        }
        
        sut.reloadCollectionViewClosure = {
            XCTFail("Try to load in error")
            exp.fulfill()
        }

        repository.complete(with: NSError(domain: "Test", code: 0))
        sut.fetchHeroes()
        
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_viewModel_OnFetchHeroes() {
        let (sut, repository) = makeSUT()
        let hero1 = makeHero(name: "Wilson", id: 1)
        let hero2 = makeHero(name: "Zoe", id: 2)
        let exp = expectation(description: "Wait for response")
        
        sut.showErrorView = { message in
            XCTFail("Did not loaded correct data")
            exp.fulfill()
        }
        
        sut.reloadCollectionViewClosure = {
            XCTAssertEqual(sut.heroesToDisplay.count, 2)
            XCTAssertEqual(sut.heroesToDisplay[0].id, 1)
            XCTAssertEqual(sut.heroesToDisplay[1].id, 2)
            exp.fulfill()
        }
        
        repository.complete(withHero: hero1.hero)
        repository.complete(withHero: hero2.hero)
        sut.fetchHeroes()
        
        wait(for: [exp], timeout: 2.0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath,
                         line: UInt = #line) -> (sut: HeroViewModelProtocol, repository: SpyRepository) {
        
        let repository = SpyRepository()
        let sut = HeroViewModel(listRepository: repository, favoriteManager: FavoriteManager())
        
        return (sut, repository)
    }
}

class SpyRepository: RepositoryProtocol {
    var error: Error? = nil
    var heroes: [Hero] = []
    
    func fetchHeroes(nameStartsWith: String, completion: @escaping ([MarvelCO.Hero], Error?) -> Void) {
        completion(heroes, error)
    }
    
    func saveHeroes(_ heroes: [MarvelCO.Hero], completion: @escaping (Error?) -> Void) {
        // [gfsf] apagar
    }
    
    func complete(with error: Error) {
        self.error = error
    }
    
    func complete(withHero hero: Hero) {
        self.heroes.append(hero)
    }   
}
