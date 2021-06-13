//
//  DataBaseManager.swift
//  TestProject
//
//  Created by galiev nail on 12.06.2021.
//

import Foundation
import CoreData

class DataBaseManager {
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveDataToCoreData(countries: [Country], context: NSManagedObjectContext) {
        context.perform {
            for country in countries {
                let countryEntity = CountryEntity(context: context)
                countryEntity.capital = country.capital
                countryEntity.continent = country.continent
                countryEntity.descriptionSmall = country.descriptionSmall
                countryEntity.descriptions = country.description
                countryEntity.name = country.name
                
                countryEntity.population = Int16(country.population!)
                countryEntity.image = country.image
            }
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Fail to save \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
