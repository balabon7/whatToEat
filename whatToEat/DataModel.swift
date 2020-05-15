//
//  DataModel.swift
//  whatToEat
//
//  Created by mac on 03.04.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import Foundation

var items = [String]()

let sectionsWithFood = [addHere,allFood]

struct DataHistory: Codable {
    
    var date: String
    var value: [String]

}

var models = [DataHistory]()
let defaults = UserDefaults.standard
var decodedObject: [DataHistory] = [DataHistory]()

