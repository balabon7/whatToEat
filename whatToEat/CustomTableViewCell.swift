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

class CustomTableViewCell: UITableViewCell, UITextFieldDelegate  {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
   weak var delegate: ButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.delegate = self
    }
    
    // Max length UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if(textField == textField){
           let currentText = textField.text! + string
           return currentText.count <= 14
        }
        return true
      }
    
    
    // Add a new value with textField when you click button
    @IBAction func addButton(_ sender: UIButton) {
        
        guard let text = textField.text else {return}
        addNewItem(nameItem: text)
        
        self.delegate?.whenTapAdd(sender: sender)
        textField.text = nil
    }
    
    // Hide the keyboard after pressing the return button
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}

