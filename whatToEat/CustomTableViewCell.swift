//
//  CustomTableViewCell.swift
//  whatToEat
//
//  Created by mac on 24.03.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

protocol ButtonDelegate: class {
    func whenTapAdd(sender: UIButton)
}

class CustomTableViewCell: UITableViewCell,  UITextFieldDelegate  {

    @IBOutlet weak var newItemTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
   weak var delegate: ButtonDelegate?
    
    @IBAction func addButton(_ sender: UIButton) {
        
        guard let text = newItemTextField.text else {return}
        addNewItem(nameItem: text)
        
        self.delegate?.whenTapAdd(sender: sender)
        newItemTextField.text = nil
    }
    
    
}
