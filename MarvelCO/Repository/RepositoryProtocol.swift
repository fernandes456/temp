//
//  RepositoryProtocol.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 07/04/24.
//

import Foundation

typealias RepositoryProtocol = FetchProtocol & SaveProtocol

protocol FetchProtocol {
    func fetchHeroes(completion: @escaping ([Hero], Error?) -> Void)
}

protocol SaveProtocol {
    func saveHeroes(_ heroes: [Hero], completion: @escaping (Error?) -> Void)
}
