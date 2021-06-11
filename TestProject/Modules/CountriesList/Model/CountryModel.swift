//
//  CountryModel.swift
//  TestProject
//
//  Created by galiev nail on 09.06.2021.
//

import Foundation

struct CountryModel: Codable {
    let next: String?
    let countries: [Country]
}
