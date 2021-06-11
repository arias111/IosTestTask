//
//  ApiSerivce.swift
//  TestProject
//
//  Created by galiev nail on 09.06.2021.
//

import Foundation

protocol ApiService {
    func loadCountry(url: String, completion: @escaping (Result<CountryModel, Error>) -> Void)
}
