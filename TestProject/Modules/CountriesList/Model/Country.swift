//
//  Countries.swift
//  TestProject
//
//  Created by galiev nail on 09.06.2021.
//

import Foundation
struct Country: Codable {
    let name: String?
    let continent: String?
    let capital: String?
    let population: Int?
    let descriptionSmall: String?
    let description: String?
    let image: String?
    let countryInfo: CountryInfo?
}

