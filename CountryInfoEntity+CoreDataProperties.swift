//
//  CountryInfoEntity+CoreDataProperties.swift
//  TestProject
//
//  Created by galiev nail on 12.06.2021.
//
//

import Foundation
import CoreData


extension CountryInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryInfoEntity> {
        return NSFetchRequest<CountryInfoEntity>(entityName: "CountryInfoEntity")
    }

    @NSManaged public var images: [String]?
    @NSManaged public var flag: String?
    @NSManaged public var countryInfo: CountryEntity?

}

extension CountryInfoEntity : Identifiable {

}
