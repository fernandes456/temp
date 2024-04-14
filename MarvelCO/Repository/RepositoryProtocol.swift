//
//  RepositoryProtocol.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 07/04/24.
//

import Foundation

protocol FetchProtocol {
    func fetchHeroes(completion: @escaping ([Hero], Error?) -> Void)
    func fetchHeroes(nameStartsWith: String, completion: @escaping ([Hero], Error?) -> Void)
}

extension FetchProtocol {
    func fetchHeroes(completion: @escaping ([Hero], Error?) -> Void) {
        self.fetchHeroes(nameStartsWith: "", completion: completion)
    }
}
