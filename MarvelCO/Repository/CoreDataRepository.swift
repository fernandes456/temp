//
//  CoreDataRepository.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 07/04/24.
//

import UIKit
import CoreData

protocol FavoriteProtocol {
    func saveToCoreData(hero: Hero, isFavorite: Bool)
}

struct CoreDataRepository: FavoriteProtocol {
    func saveToCoreData(hero: Hero, isFavorite: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Character", in: managedContext)!
//        let characterToSave = NSManagedObject(entity: entity, insertInto: managedContext) as! Character
        
//        characterToSave.name = character.name
//        characterToSave.descriptionString = character.description
//        characterToSave.imageUrl = character.imageUrl
        
        do {
            try managedContext.save()
            print("Saved successfully")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
