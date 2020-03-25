//
//  FoodSheetViewController.swift
//  whatToEat
//
//  Created by mac on 24.03.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

class FoodSheetViewController: UIViewController {
    
  //  @IBOutlet weak var FoodTableView: UITableView!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //self.navigationItem.title = "Что покушаем?"
        // self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let randomName = arrayWithFood.randomElement()
        print("Random _>", randomName!)
    
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
            //cell.textLabel?.text = "Поле для ввода еды.."
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as!CustomTableViewCell
            
            cell.addButton.isHidden = true
            cell.addButton.tintColor = #colorLiteral(red: 0.2274509804, green: 0.7882352941, blue: 0.3764705882, alpha: 1)
            cell.addButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.7882352941, blue: 0.3764705882, alpha: 1)
            cell.newDishTexField.isHidden = true
            cell.textLabel?.text = arrayWithFood[indexPath.row]
            return cell
        }
    }

}
