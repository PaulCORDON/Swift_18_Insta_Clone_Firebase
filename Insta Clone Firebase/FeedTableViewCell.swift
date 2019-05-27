//
//  FeedTableViewCell.swift
//  Insta Clone Firebase
//
//  Created by MAC-DIN-002 on 24/05/2019.
//  Copyright © 2019 MAC-DIN-002. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var postUserName: UILabel!
    @IBOutlet weak var postComment: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
