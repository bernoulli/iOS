//
//  Array+Only.swift
//  Memorize
//
//  Created by Bernardo Cuervo on 24/10/21.
//  Copyright © 2021 Bernardo Cuervo. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
