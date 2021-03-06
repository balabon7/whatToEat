//
//  History ViewController.swift
//  whatToEat
//
//  Created by mac on 01.05.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Clear button properties
    private let button: UIButton = {
        let view = AnimationButton()
        view.setAttributedTitle(NSAttributedString(string: clear, attributes: [.font : UIFont.boldSystemFont(ofSize: 17), .foregroundColor : UIColor.white]), for: .normal)
        view.backgroundColor = #colorLiteral(red: 1, green: 0.6056655049, blue: 0, alpha: 1)
        view.touchUpColor = #colorLiteral(red: 1, green: 0.6056655049, blue: 0, alpha: 1)
        view.touchDownColor = #colorLiteral(red: 0.8954037119, green: 0.5242311732, blue: 0.006521536724, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    // MARK: - Empty List Label
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = emptyList
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Contraints
    private func activateContraints() {
        // Clear Button
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Empty List Label
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 300).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK: -  ButtonViewAndContraints
    private func setupViews() {
        view.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clearButtonAction), for: .touchUpInside)
        view.addSubview(button)
        view.addSubview(label)
    }
    
    @objc func clearButtonAction(){
        decodedObject.removeAll()
        UserDefaults.standard.encode(for:decodedObject, using: String(describing: DataHistory.self))
        tableView.reloadData()
        
        button.fadeOut() // button.isHidden = true
        label.fadeIn() //label.isHidden = false
    }
    
    // MARK: -  View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        activateContraints()
        tableView.tableFooterView = UIView() // hide unnecessary table lines
        self.navigationItem.title = history

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "shareFile"), style: .plain, target: self, action: #selector(shareCSVButtonPressed))
        
        if decodedObject.isEmpty {
            button.isHidden = true
            label.isHidden = false
        } else {
            button.isHidden = false
            label.isHidden = true
        }
    }
        
    @objc func shareCSVButtonPressed() {
        guard let pathCVS = createCSV(from: decodedObject) else { return }
        
        let activityVC = UIActivityViewController(activityItems: [pathCVS], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    // Convert String Array to String
    func getString(array : [String]) -> String {
        let stringArray = array.map{ String($0) }
        return stringArray.joined(separator: ",")
    }
    
    // MARK: CSV file creating
    func createCSV(from array:[DataHistory]) -> URL? {
        let fileName = "History.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvString = "\(dateAndTime),\(food)\n\n"
        
        for item in array {
            csvString = csvString.appending("\(String(describing: item.date)) ,\(String(describing: getString(array: item.value)))\n")
        }
        
        do {
            try csvString.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        return path
    }
}

// MARK: - TableView Protocols: Delegate and DataSource
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return decodedObject.count
    }
    
    //The name of each section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let section = decodedObject[section].date
        return section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decodedObject[section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        cell.textLabel?.text = decodedObject[indexPath.section].value[indexPath.row]
        return cell
    }
}
