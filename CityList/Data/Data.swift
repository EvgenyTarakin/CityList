//
//  Data.swift
//  CityList
//
//  Created by Евгений Таракин on 23.07.2025.
//

import UIKit

// MARK: - Structs

struct List {
    let name: String
    let fullName: String
    let color: UIColor
    var indexesCities: [Int]
}

struct City {
    let name: String
    let date: String
}

// MARK: - Data

var selectedListIndex: Int = 0

var allLists: [List] = [List(name: "Европа",
                             fullName: "Список городов Европы",
                             color: .systemBlue,
                             indexesCities: [8, 9, 10, 11, 12])]

var allCities: [City] = [City(name: "Москва", date: "1147 год"),
                         City(name: "Санкт-Петербург", date: "1703 год"),
                         City(name: "Хабаровск", date: "1858 год"),
                         City(name: "Ираклион", date: "824 год"),
                         City(name: "Афины", date: "6000 год до н.э."),
                         City(name: "Мюнхен", date: "1158 год"),
                         City(name: "Линц", date: "15 год до н.э."),
                         City(name: "Зальцбург", date: "700 год"),
                         City(name: "Париж", date: "III век до н.э."),
                         City(name: "Вена", date: "1147 год"),
                         City(name: "Берлин", date: "1237 год"),
                         City(name: "Варшава", date: "1321 год"),
                         City(name: "Милан", date: "около 600 до н.э."),
                         City(name: "Мадрид", date: "893 год"),
                         City(name: "Барселона", date: "III век до н.э."),
                         City(name: "Лондон", date: "47 год"),
                         City(name: "Новосибирск", date: "1893 год"),
                         City(name: "Канберра", date: "1913 год"),
                         City(name: "Пекин", date: "1045 год до н.э."),
                         City(name: "Бангкок", date: "1782 год")]
