//
//  Brunch.swift
//  Circuit
//
//  Created by Djuro Alfirevic on 12/8/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import Foundation
import UIKit

struct Brunch {
    
    // MARK: - Properties
    var name: String
    var description: String
    var distance: Double
    var image: UIImage
    var review: String?
    
    // MARK: - Designated Initializer
    init(name: String, description: String, distance: Double, image: UIImage) {
        self.name = name;
        self.description = description
        self.distance = distance
        self.image = image
    }
    
    // MARK: - Public API
    func formattedDistance() -> String {
        return String(format: "%.2fkm", distance)
    }
    
}
