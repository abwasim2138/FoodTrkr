//
//  MealTableViewCell.swift
//  FoodTrkr
//
//  Created by Layla Nawawi on 9/23/15.
//  Copyright © 2015 Laylapp. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    // MARK: Properties 
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingContol!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
