//
//  readMe.swift
//  TestProject
//
//  Created by galiev nail on 13.06.2021.
//

import Foundation
// MARK: - Смотреть после проверки

// Дополнительный вариант проверки так как мог не правильно понять задачу
/*
    // Проверяем пустой ли массив
    // если нет то достаем картинку из image
    // если и там нет то берем флаг страны
 
    private func isImagesPresent() -> Int {
        
        if country?.countryInfo?.images.count != 0 {
            
            for i in (country?.countryInfo?.images)! {
                if i.isValidURL {
                    urls.append(URL(string: i)!)
                }
            }
            pageControl.numberOfPages = urls.count
            return urls.count
            
        }
        else if country?.image?.count != 0 {
            if (country?.image?.isValidURL)! {
                pageControl.numberOfPages = 1
                urls.append(URL(string: (country?.image)!)!)
                return 1
            }
            return 0
        }
        else {
            urls.append(URL(string: (country?.countryInfo?.flag)!)!)
            pageControl.numberOfPages = 1
            return 1
        }
    }
}
*/
