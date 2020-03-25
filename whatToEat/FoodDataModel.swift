//
//  FoodDataModel.swift
//  whatToEat
//
//  Created by mac on 24.03.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import Foundation

var arrayWithFood = ["Макароны", "Рис", "Гречка", "Суши", "Суп", "Салат", "Картошка"]
let sectionsWithFood = ["Что добавим?", "Вся еда"]

func addItem(nameItem: String) {
    arrayWithFood.append(nameItem)
    saveData()
}

func removeItem(at index: Int) {
    arrayWithFood.remove(at: index)
    saveData()
}

func saveData() {
    
}

func loadData() {
    
}
