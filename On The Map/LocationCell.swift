//
//  LocationCell.swift
//  On The Map
//
//  Created by Abdul Bagasra on 1/14/16.
//  Copyright © 2016 TAIMS Inc. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: Properties
    var locationData: Artwork? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Functions
    func updateUI() {
        nameLabel.text = locationData!.title
    }

}
