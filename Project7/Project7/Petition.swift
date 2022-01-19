//
//  Petition.swift
//  Project7
//
//  Created by Bernardo Cuervo on 16/01/22.
//  Copyright © 2022 Bernardo Cuervo. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
