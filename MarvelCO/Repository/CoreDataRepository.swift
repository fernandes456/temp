//
//  CoreDataRepository.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 07/04/24.
//

import UIKit
import CoreData

protocol FavoriteProtocol {
    func addToFavorite(hero: Hero)
    func removeFromFavorite(hero: Hero)
    func fetchFavorite(completion: @escaping ([Hero]) -> Void)
}

struct CoreDataRepository: FavoriteProtocol {
    private let ENITITY_NAME = "FavoriteHero"
    
    func addToFavorite(hero: Hero) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: ENITITY_NAME, in: managedContext) {

            if let heroToSave = NSManagedObject(entity: entity, insertInto: managedContext) as? FavoriteHero {
                heroToSave.heroId = Int32(hero.id)
                heroToSave.heroName = hero.name
                heroToSave.heroDescription = hero.description
            }

        }
        do {
            try managedContext.save()
            print("Saved successfully")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func removeFromFavorite(hero: Hero) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: ENITITY_NAME)
        fetchRequest.predicate = NSPredicate(format: "heroId == %d", hero.id)
        
        do {
            let foveriteHeroes = try managedContext.fetch(fetchRequest)
            if let favoriteHeroToDelete = foveriteHeroes.first {
                managedContext.delete(favoriteHeroToDelete)
                try managedContext.save()
                print("Character deleted successfully")
            }
        } catch let error as NSError {
            print("Could not fetch or delete. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllFavoriteHeroes() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: ENITITY_NAME)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
            print("All characters deleted successfully")
        } catch let error as NSError {
            print("Could not delete all characters. \(error), \(error.userInfo)")
        }
    }

    
    func fetchFavorite(completion: @escaping ([Hero]) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion([])
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: ENITITY_NAME)

        managedContext.perform {
            do {
                let characterObjects = try fetchRequest.execute()
                let characters = characterObjects.map { managedObject in
                    Hero(
                        id: managedObject.value(forKeyPath: "heroId") as? Int ?? 0,
                        name: managedObject.value(forKey: "heroName") as? String ?? "",
                        description: managedObject.value(forKey: "heroDescription") as? String ?? "", 
                        thumbnail: Thumbnail(path: "https://images.immediate.co.uk/production/volatile/sites/3/2023/10/INVIS2FG00113118Still1533000-036fc34", extension: "jpg")
                    )
                }
                DispatchQueue.main.async {
                    completion(characters)
                }
            } catch let error as NSError {
                print("Não foi possível buscar dados. \(error), \(error.userInfo)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
}


