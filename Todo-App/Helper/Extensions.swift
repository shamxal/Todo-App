//
//  Extensions.swift
//  Todo-App
//
//  Created by Shamkhal Guliyev on 3.10.2017.
//  Copyright © 2017 Shamkhal Guliyev. All rights reserved.
//

import UIKit
import RealmSwift

extension HomeVC {
    
    //filter list with name and created date by using action sheet
    func showActionSheet() {
        
        let actionSheet: UIAlertController = UIAlertController(title: "Sort by", message: "", preferredStyle: .actionSheet)
        
        let name = UIAlertAction(title: "Name", style: .default) { _ in
            self.reloadDb(keyPath: "title")
        }
        let date = UIAlertAction(title: "Date", style: .default) { _ in
            self.reloadDb(keyPath: "date")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(name)
        actionSheet.addAction(date)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //get all datas from sorting by given key
    func reloadDb(keyPath: String) {
        let realmObj = try! Realm()
        arrResult = realmObj.objects(Todo.self).sorted(byKeyPath: keyPath)
        
        tableList.reloadData()
    }
    
    //search bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let predicate = NSPredicate(format: "title contains[c] %@", searchText)
        let realm = try! Realm()
        arrResult = realm.objects(Todo.self).filter(predicate)
        tableList.reloadData()
    }
}

extension UIViewController {
    
    func getCurrentDate() -> String {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd H:m:ss.SSSS"
        return formatter.string(from: date)
    }
    
    func noteAddedAlert(message: String) {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
