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

