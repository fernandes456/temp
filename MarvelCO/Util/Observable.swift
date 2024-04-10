//
//  Observable.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 08/04/24.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }
    
    var valueChanged: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
}
