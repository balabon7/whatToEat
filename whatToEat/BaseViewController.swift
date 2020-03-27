//
//  BaseViewController.swift
//  whatToEat
//
//  Created by mac on 26.03.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    func addNewItem(nameItem: String) {
        arrayWithFood.append(nameItem)
        saveData()
    }

    func removeItem(at index: Int) {
        arrayWithFood.remove(at: index)
        saveData()
    }

    func saveData() {
        UserDefaults.standard.set(arrayWithFood, forKey: "FoodData")
        UserDefaults.standard.synchronize()
    }

    func loadData() {
        if let arrayData = UserDefaults.standard.array(forKey: "FoodData" )  {
            arrayWithFood = arrayData as! [String]
        } else {
            arrayWithFood = ["Макароны", "Рис", "Гречка", "Суши", "Суп", "Салат", "Картошка"]
        }
        
    }
    
    //MARK: Show Alert WithOut Action
    
    func showAlert(title: String, message: String) {
      DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
      }
    }
    
    //MARK: Display Random Value From Array Of Food
    func displayRandomValueFromArrayOfFood(item: String? ) -> String {
        guard let item = item else {
            return "No value exists"
        }
        return item
    }
    
}
