//
//  BaseViewController.swift
//  whatToEat
//
//  Created by mac on 26.03.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
    //MARK:  - Display Random Value From Array Of Food
    func displayRandomValueFromArrayOfFood(item: String? ) -> String {
        guard let item = item else {
            return noValueExists
        }
        return item
    }
}

// MARK: - Hide Keyboard When Tapped Around
extension BaseViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard(){
        view.endEditing(true)
    }
}


extension UserDefaults {
    func decode<T : Codable>(for type : T.Type, using key : String) -> T? {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: key) as? Data else {return nil}
        let decodedObject = try? PropertyListDecoder().decode(type, from: data)
        return decodedObject
    }

    func encode<T : Codable>(for type : T, using key : String) {
        let defaults = UserDefaults.standard
        let encodedData = try? PropertyListEncoder().encode(type)
        defaults.set(encodedData, forKey: key)
        defaults.synchronize()
    }
}
