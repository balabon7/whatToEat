//
//  FoodSheetViewController.swift
//  whatToEat
//
//  Created by mac on 24.03.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, ButtonDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var customTableViewCell = CustomTableViewCell()
    
    // MARK: - Generate button properties
    private let button: UIButton = {
        let view = UIButton()
        view.setAttributedTitle(NSAttributedString(string: "Generate", attributes: [.font : UIFont.boldSystemFont(ofSize: 17), .foregroundColor : UIColor.white]), for: .normal)
        view.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.7882352941, blue: 0.3764705882, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupViews()
        activateContraints()
        
        hideKeyboardWhenTappedAround()
        customTableViewCell.delegate = self
        
        self.navigationItem.title = "What to eat?" //"Что покушаем?"
        tableView.tableFooterView = UIView() // hide unnecessary table lines
        
        // self.navigationController?.navigationBar.prefersLargeTitles = true
//        tableView.allowsMultipleSelectionDuringEditing = true  //add checkmark
//        tableView.setEditing(true, animated: false)
    }
    
    // MARK: -  ButtonViewAndContraints
    private func setupViews() {
        view.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(generateButtonAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    private func activateContraints() {
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // Action for button generate
    @objc func generateButtonAction() {
        
        let randomItem = displayRandomValueFromArrayOfFood(item: items.randomElement())
        showAlert(title: "It's..", message: randomItem)
    }
    
    //MARK: - Protocol Delegate
    func whenTapAdd(sender: UIButton) {
        // print("Protocol on button Tap")
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    // number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsWithFood.count
    }
    
    //The name of each section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sectionsWithFood[section]
        return section
    }
    
    // Number of cells in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return items.count
        }
    }
    
    // Set cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.delegate = self
        
        if indexPath.section == 0 {
            cell.addButton.isHidden = false
            cell.newItemTextField.isHidden = false
            cell.newItemTextField.placeholder = "New item"
            
            cell.textLabel?.isHidden = true
            return cell
        } else {
            
            cell.addButton.isHidden = true
            cell.newItemTextField.isHidden = true
            cell.textLabel?.isHidden = false
            cell.textLabel?.text = items[indexPath.row]
            return cell
        }
    }
    
    // didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //            print("Did select")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Remote cell in canEdit and editingStile
    func tableView(_ tableView: UITableView,  canEditRowAt indexPath: IndexPath) -> Bool {
        
        if indexPath.section == 0 {
            return false
        } else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
}
