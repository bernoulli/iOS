//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Bernardo Cuervo on 24/10/21.
//  Copyright © 2021 Bernardo Cuervo. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
