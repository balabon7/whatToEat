//
//  FoodSheetViewController.swift
//  whatToEat
//
//  Created by mac on 24.03.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

class FoodSheetViewController: BaseViewController {
    
    // FIXME: FoodTableView
    @IBOutlet weak var foodTableView: UITableView! // FIX
    // FIXME: viewCell
    let viewCell = CustomTableViewCell() // FIX
    
    private let button: UIButton = {
        let view = UIButton()
        view.setAttributedTitle(NSAttributedString(string: "Сенерировать", attributes: [.font : UIFont.systemFont(ofSize: 20), .foregroundColor : UIColor.white]), for: .normal)
        view.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.7882352941, blue: 0.3764705882, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        // self.view.backgroundColor = UIColor.white
        setupViews()
        activateContraints()
        
        
        // add generator button
        
        
        
        //        let buttoтGen = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        //        buttoтGen.backgroundColor = .blue
        //        buttoтGen.setTitle("Test Button", for: .normal)
        //        buttoтGen.addTarget(self, action: #selector(addDishAction), for: .touchUpInside)
        //        self.view.addSubview(buttoтGen)
        
        
        self.navigationItem.title = "Что покушаем?"
        
        foodTableView.tableFooterView = UIView() // hide unnecessary table lines
        // self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //        foodTableView.allowsMultipleSelectionDuringEditing = true  add checkmark
        //        foodTableView.setEditing(true, animated: false)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        // foodTableView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(generateButtonAction), for: .touchUpInside)
        // view.addSubview(foodTableView)
        view.addSubview(button)
    }
    
    private func activateContraints() {
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 46).isActive = true
    }
    
    // Action for button generate
    @objc func generateButtonAction(_ sender: UIButton) {
        
        let randomItem = displayRandomValueFromArrayOfFood(item: arrayWithFood.randomElement())
        showAlert(title: "И этооо.....", message: randomItem)
    }
    
    // Action for button Add
    @IBAction func addDishAction(_ sender: UIButton) {
        
        addNewItem(nameItem: "Name Item")
        foodTableView.reloadData()
        print(arrayWithFood)
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
    
    
}
