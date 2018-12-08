//
//  UIViewController+Extensions.swift
//  Circuit
//
//  Created by Djuro Alfirevic on 12/8/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Buttons.ok, style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
