//
//  HomeVC.swift
//  Todo-App
//
//  Created by Shamkhal Guliyev on 2.10.2017.
//  Copyright © 2017 Shamkhal Guliyev. All rights reserved.
//

import UIKit
import RealmSwift

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableList: UITableView!
    @IBOutlet weak var search: UISearchBar!
    
    var arrResult: Results<Todo>?
    var refresh: UIRefreshControl!
    
    fileprivate func setupTableRefresh() {
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableList.addSubview(refresh)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        setupTableRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadDb(keyPath: "date")
    }
    
    @objc private func refreshTable() {
        refresh.endRefreshing()
        reloadDb(keyPath: "date")
    }
    
    //table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrResult!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodoCell
        
        let todo = arrResult![indexPath.row]
        cell.lblTitle.text = todo.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let addVC = storyboard?.instantiateViewController(withIdentifier: "AddNoteVC") as! AddNoteVC
        addVC.isNew = false
        addVC.note = arrResult![indexPath.row]
        navigationController?.show(addVC, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let realm = try! Realm()
            let todo = arrResult![indexPath.row]
            try! realm.write {
                realm.delete(todo)
            }
            arrResult = realm.objects(Todo.self)
            tableList.reloadData()
        }
    }
    
    @IBAction func btnFilter(_ sender: Any) {
        showActionSheet()
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        let addVC = storyboard?.instantiateViewController(withIdentifier: "AddNoteVC") as! AddNoteVC
        addVC.isNew = true
        navigationController?.show(addVC, sender: nil)
    }
}
