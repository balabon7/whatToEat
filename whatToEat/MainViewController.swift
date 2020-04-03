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
    
    private var timer: Timer?
    
    // MARK: - Generate button properties
    private let button: UIButton = {
        let view = UIButton()
        view.setAttributedTitle(NSAttributedString(string: generate, attributes: [.font : UIFont.boldSystemFont(ofSize: 17), .foregroundColor : UIColor.white]), for: .normal)
        view.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.7882352941, blue: 0.3764705882, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    //MARK: -  Blur View
    private let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        let blurEffect = UIBlurEffect(style: .prominent)
        view.effect = blurEffect
        return view
    }()
    
    //MARK: -  Blur View Label
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        activateContraints()
        blurView.isHidden = true
        hideViewWhenTappedAround()
        
        self.navigationItem.title = whatToEat
        tableView.tableFooterView = UIView() // hide unnecessary table lines
        
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        tableView.allowsMultipleSelectionDuringEditing = true  //add checkmark
//        tableView.setEditing(true, animated: false)
    }
    
    // MARK: -  ButtonViewAndContraints
    private func setupViews() {
        view.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(generateButtonAction), for: .touchUpInside)
        view.addSubview(button)
        view.addSubview(blurView)
        
    }
    
    private func activateContraints() {
        // Generate Button
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Blure view
        blurView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blurView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        blurView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        // Blur button label
        blurView.contentView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: blurView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: blurView.centerYAnchor).isActive = true
    }
    
    //  Action for button generate - Timer
    @objc func anyTimerHey() {
        let randomItem = displayRandomValueFromArrayOfFood(item: items.randomElement())
        label.text = randomItem
        
    }
    
    //MARK: - Hide Custom Blur View then tap area
    func hideViewWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideView))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideView(){
        blurView.isHidden = true
    }
    
    
    //MARK: - Action for button Generate
    @objc func generateButtonAction() {
        blurView.isHidden = false
        
        var runCount = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.anyTimerHey()
            runCount += 1
            if runCount == 14 {
                timer.invalidate()
            }
        }
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
            cell.textField.isHidden = false
            cell.textField.placeholder = dishName
            
            cell.textLabel?.isHidden = true
            return cell
        } else {
            
            cell.addButton.isHidden = true
            cell.textField.isHidden = true
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
