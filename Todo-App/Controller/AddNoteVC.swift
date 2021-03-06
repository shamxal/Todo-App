//
//  AddNoteVC.swift
//  Todo-App
//
//  Created by Shamkhal Guliyev on 2.10.2017.
//  Copyright © 2017 Shamkhal Guliyev. All rights reserved.
//

import UIKit
import RealmSwift

class AddNoteVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var txtViewNote: UITextView!
    
    var note: Todo?
    var isNew = true
    var realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Note"
        
        if !isNew {
            txtViewNote.text = note?.title
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        textView.text = ""
        textView.alpha = 1
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            if textView.text.characters.count == 0 {
                textView.text = "Type..."
                textView.alpha = 0.55
            }
        }
        return true
    }
    
    func incrementId() -> Int {
        
        let realm = try! Realm()
        return (realm.objects(Todo.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    @IBAction func btnSave(_ sender: Any) {
        
        if txtViewNote.text.characters.count > 0 && txtViewNote.text != "Type..."{
            
            if isNew {
                let todo = Todo()
                todo.id = incrementId()
                todo.title = txtViewNote.text
                todo.date = getCurrentDate()
                
                try! realm.write {
                    realm.add(todo)
                    noteAddedAlert(message: "Your note added", handler: nil)
                }
            } else {
                let todo = Todo()
                todo.id = note!.id
                todo.title = txtViewNote.text
                todo.date = getCurrentDate()
                
                try! realm.write {
                    realm.add(todo, update: true)
                    noteAddedAlert(message: "Your note updated", handler: nil)
                }
            }
        }
    }
}
