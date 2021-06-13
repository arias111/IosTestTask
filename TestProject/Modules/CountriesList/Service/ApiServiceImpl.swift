//
//  ApiServiceImpl.swift
//  TestProject
//
//  Created by galiev nail on 09.06.2021.
//

import Foundation

class ApiServiceImpl: ApiService {
    func loadCountry(url: String, completion: @escaping (Result<CountryModel, Error>) -> Void) {
        guard let url = URL(string: url)
        else { return }
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        // Получаем данные с сервера
        let session = URLSession(configuration: configuration)
        session.dataTask(with: url) { data,response,error  in
            guard let data = data
            else { return }
            let request = URLRequest(url: url)
            //Для себя проверяю сохранились ли данные в кэше
            var isFromCache = false
            if URLCache.shared.cachedResponse(for: request) != nil {
                isFromCache = true
                print(isFromCache)
            }
            // Парсим данные с Json
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let country = try decoder.decode(CountryModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(country))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                print(error.localizedDescription)
            }
        }.resume()
    }
}
