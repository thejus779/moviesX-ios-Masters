//
//  MoviesTableViewCell.swift
//  moviesX
//
//  Created by thejus manoharan on 24/04/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import UIKit
import STRatingControl

class MoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewRatings: STRatingControl!
    @IBOutlet weak var imgMovie: UICustomeImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
