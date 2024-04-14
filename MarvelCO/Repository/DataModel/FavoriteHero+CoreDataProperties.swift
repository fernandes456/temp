//
//  FavoriteHero+CoreDataProperties.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 11/04/24.
//
//

import Foundation
import CoreData


extension FavoriteHero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteHero> {
        return NSFetchRequest<FavoriteHero>(entityName: "FavoriteHero")
    }

    @NSManaged public var heroId: Int32
    @NSManaged public var heroName: String?
    @NSManaged public var heroDescription: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var thumbnailExtension: String?

}

extension FavoriteHero : Identifiable {

}
