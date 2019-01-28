//
//  DetailViewController.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/13/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var results: [Result] = []
    var characters: [Character] = []
    var vehicles: [Vehicle] = []
    var starships: [Starship] = []
    var planets: [Planet] = []
    var selectedResult: Result?
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1058823529, green: 0.1254901961, blue: 0.1411764706, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.5529411765, green: 0.5647058824, blue: 0.5725490196, alpha: 1)
    }
    
    func updateView() {
        //TODO: update table view
    }
}

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "infoTableViewCell", for: indexPath) as? InfoCell else { fatalError() }
        
        let tableViewHeight = tableView.bounds.height
        
        tableView.rowHeight = (tableViewHeight/5)
        if let result = selectedResult {
            cell.configureCell(with: result, row: indexPath.row, nameLable: nameLabel)
        } else {
            cell.configureCell(with: results[0], row: indexPath.row, nameLable: nameLabel)
        }
        
        return cell
    }
}

extension DetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return results.count
    }
}

extension DetailViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return results[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedResult = results[row]
        tableView.reloadData()
    }
}
