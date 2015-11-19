//
//  ListCell.swift
//  synthesis
//
//  Created by XingfuQiu on 15/11/18.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var titleDetail: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }    

}
