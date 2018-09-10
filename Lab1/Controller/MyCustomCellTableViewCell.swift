//
//  myCustomCellTableViewCell.swift
//  Lab1
//
//  Created by Sanaz Khosravi on 8/31/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit

class MyCustomCellTableViewCell: UITableViewCell {

    
    @IBOutlet var myImageView: UIImageView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
