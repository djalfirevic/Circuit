//
//  BrunchTableViewCell.swift
//  Circuit
//
//  Created by Djuro Alfirevic on 12/8/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import UIKit

class BrunchTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var brunchImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    var brunch: Brunch! {
        didSet {
            setup()
        }
    }
    
    // MARK: - Private API
    private func setup() {
        brunchImageView.image = brunch.image
        nameLabel.text = brunch.name
        descriptionLabel.text = brunch.description
        distanceLabel.text = brunch.formattedDistance()
    }

}
