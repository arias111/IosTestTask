//
//  CountryEntity+CoreDataProperties.swift
//  TestProject
//
//  Created by galiev nail on 12.06.2021.
//
//

import Foundation
import CoreData


extension CountryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryEntity> {
        return NSFetchRequest<CountryEntity>(entityName: "CountryEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var continent: String?
    @NSManaged public var capital: String?
    @NSManaged public var population: Int16
    @NSManaged public var descriptionSmall: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var image: String?
    @NSManaged public var countries: CountryModelEntity?
    @NSManaged public var countryInfo: CountryInfoEntity?

}

extension CountryEntity : Identifiable {

}
