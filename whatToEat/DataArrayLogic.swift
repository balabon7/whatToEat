//
//  DataArrayLogic.swift
//  whatToEat
//
//  Created by mac on 01.04.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import Foundation

func addNewItem(nameItem: String) {
    
    guard nameItem != "" else {return}
    items.append(nameItem)
    saveData()
}

func removeItem(at index: Int) {
    items.remove(at: index)
    saveData()
}

func saveData() {
    UserDefaults.standard.set(items, forKey: "FoodData")
    UserDefaults.standard.synchronize()
}

func loadData() {
    if let arrayData = UserDefaults.standard.array(forKey: "FoodData" )  {
        items = arrayData as! [String]
    } else {
        items = [omelette, boiledBuckwheat, pilaf, soup, salad, pasta]
    }
}

func addDateFor(item: String) {

    guard item != "" else {return}
    
    let df = DateFormatter()
    df.dateFormat = "dd/MM/yyyy HH:mm:ss"
    let strDate = df.string(from: Date())
    let historyData = DataHistory(date: strDate, value: [item])

    decodedObject.append(historyData)
    UserDefaults.standard.encode(for:decodedObject, using: String(describing: DataHistory.self))
}
