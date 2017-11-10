//
//  TodoCell.swift
//  Todo-App
//
//  Created by Shamkhal Guliyev on 2.10.2017.
//  Copyright © 2017 Shamkhal Guliyev. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
