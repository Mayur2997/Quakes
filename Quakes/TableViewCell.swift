//
//  TableViewCell.swift
//  Quakes
//
//  Created by Agstya Technologies on 19/10/19.
//  Copyright © 2019 Mayur. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    //MARK:- Outlet
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var lblMag: UILabel!
    
    //MARK:- Cell LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
