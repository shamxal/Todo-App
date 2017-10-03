//
//  Todo.swift
//  Todo-App
//
//  Created by Shamkhal Guliyev on 2.10.2017.
//  Copyright © 2017 Shamkhal Guliyev. All rights reserved.
//

import UIKit
import RealmSwift

class Todo: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var date = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
