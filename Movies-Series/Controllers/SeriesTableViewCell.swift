//
//  SeriesTableViewCell.swift
//  Movies-Series
//
//  Created by David A Cantú Delgado on 11/19/18.
//  Copyright © 2018 Bugsracer. All rights reserved.
//

import UIKit

class SeriesTableViewCell: UITableViewCell {

    @IBOutlet weak var lbSerie: UILabel!
    @IBOutlet weak var imPoster: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
