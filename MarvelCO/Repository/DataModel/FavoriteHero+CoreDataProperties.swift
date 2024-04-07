//
//  FavoriteHero+CoreDataProperties.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 07/04/24.
//
//

import Foundation
import CoreData


extension FavoriteHero {
    
    @nonobjc func fetchRequest() -> NSFetchRequest<FavoriteHero> {
        return NSFetchRequest<FavoriteHero>(entityName: "FavoriteHero")
    }

    @NSManaged public var heroId: Int32

}

extension FavoriteHero : Identifiable {

}
