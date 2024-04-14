//
//  MarvelCOTests.swift
//  MarvelCOTests
//
//  Created by Geraldo Fernandes on 03/04/24.
//

import XCTest
@testable import MarvelCO

protocol FeedLoader {
    typealias Result = Swift.Result<[Hero], Error>
    func load(limit: Int, offset: Int, completion: @escaping (Result) -> Void)
}

extension FeedLoader {
    func load(limit: Int = 30, offset: Int = 0, completion: @escaping (Result) -> Void) {
        load(limit: limit, offset: offset, completion: completion)
    }
}

protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    func get(from url: URL, completion: @escaping (Result) -> Void)
}

class RemoteFeedLoader: FeedLoader {
    private let client: HTTPClient
    private let url: URL
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    public typealias Result = FeedLoader.Result
    
    func load(limit: Int = 30, offset: Int = 0, completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                completion(HeroesMapper.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}

final class HeroesMapper {
    static func map(_ data: Data, from response: HTTPURLResponse) -> FeedLoader.Result {
        do {
            let decoder = JSONDecoder()
            let marvelResponse = try decoder.decode(MarvelResponse.self, from: data)
            return .success(marvelResponse.data.results)
        } catch {
            return .failure(error)
        }
    }
}

final class URLRequestFactory {
    private let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func makeRequest(for endpoint: String, with parameters: [String: String] = [:]) -> URLRequest? {
        var components = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components?.url else { return nil }
        return URLRequest(url: url)
    }
}

final class MarvelCOTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_init_doesNotHaveRequest() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.messages.isEmpty)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://uma-url-qualquer.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_load_ErrorOnConnectivity() {
        let (sut, client) = makeSUT()
        let exp = expectation(description: "Wait for request")
        
        sut.load { receivedResult in
            switch receivedResult {
            case .success(_):
                XCTFail("Was able to connect")
            case let .failure(error):
                XCTAssertEqual(error as! RemoteFeedLoader.Error, RemoteFeedLoader.Error.connectivity)
            }
            
            exp.fulfill()
        }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_load_receiveTwoHeroesInResponse() {
        let (sut, client) = makeSUT()
        let exp = expectation(description: "Wait for request")
        
        let hero1 = makeHero(name: "Wilson", id: 1)
        let hero2 = makeHero(name: "Zoe", id: 2)
        
        sut.load { receivedResult in
            switch receivedResult {
            case let .success(heroes):
                XCTAssertEqual(heroes, [hero1.hero, hero2.hero])
            case .failure:
                XCTFail("Unable to pass")
            }
            
            exp.fulfill()
        }
        
        client.complete(withStateCode: 200, data: makeHeroesJSON([hero1.json, hero2.json]))
        
        wait(for: [exp], timeout: 2.0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!,
                         file: StaticString = #filePath,
                         line: UInt = #line) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(client: client, url: url)
        
        return (sut, client)
    }

    private class HTTPClientSpy: HTTPClient {
        var messages = [(url: URL, completion: (HTTPClient.Result) -> Void)]()
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStateCode code: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[index],
                                           statusCode: code,
                                           httpVersion: nil,
                                           headerFields: nil)!
            messages[index].completion(.success((data, response)))
        }
        
    }
}
