//
//  CinemasTableViewCell.swift
//  moviesX
//
//  Created by thejus manoharan on 17/05/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import UIKit

class CinemasTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCinema: UICustomeImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
