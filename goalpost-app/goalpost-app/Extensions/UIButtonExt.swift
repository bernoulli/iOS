//
//  UIButtonExt.swift
//  goalpost-app
//
//  Created by Bernardo Cuervo on 10/02/22.
//  Copyright © 2022 Bernardo Cuervo. All rights reserved.
//

import UIKit

extension UIButton {
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }
}
