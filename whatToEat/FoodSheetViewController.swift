//
//  FoodSheetViewController.swift
//  whatToEat
//
//  Created by mac on 24.03.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

class FoodSheetViewController: UIViewController {
    
    
    // FIXME: FoodTableView
    @IBOutlet weak var foodTableView: UITableView! // FIX
    // FIXME: viewCell
    let viewCell = CustomTableViewCell() // FIX
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //self.navigationItem.title = "Что покушаем?"
        // self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // displayRandomValueFromArrayOfFood(array: arrayWithFood.randomElement())
        
    }
    
    
    @IBAction func addDishAction(_ sender: UIButton) {
        addItem(nameItem: "Name Item")
        foodTableView.reloadData()
        print(arrayWithFood)
        
    }
    
    func displayRandomValueFromArrayOfFood(array: String? ){
        guard let array = array else {
            return print("No value exists")
        }
        print("Random ->", array)
    }
    
}

extension FoodSheetViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsWithFood.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sectionsWithFood[section]
        return section
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return arrayWithFood.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! CustomTableViewCell
            cell.addButton.isHidden = false
            //cell.textLabel?.text = "Поле для ввода еды.."
            //cell.addButton.removeTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as!CustomTableViewCell
            
            cell.addButton.isHidden = true
            // #colorLiteral(red: 0.2274509804, green: 0.7882352941, blue: 0.3764705882, alpha: 1)
            cell.newDishTexField.isHidden = true
            cell.textLabel?.text = arrayWithFood[indexPath.row]
            return cell
        }
    }
    
    // MARK: - Remote cell
    func tableView(_ tableView: UITableView,  canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }

     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            removeItem(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {

        }
    }
    
    
    
    //    @objc func buttonClicked(sender: UIButton) {
    //       print("Target")
    //    }
    
}
