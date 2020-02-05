//
//  TheOfficeCodable.swift
//  CaptionApp-Lecture-05
//
//  Created by Rebecca  Slatkin on 2/5/20.
//  Copyright © 2020 Syracuse University. All rights reserved.
//

import Foundation

// MARK: - TheOfficeCodable
struct TheOfficeCodable: Codable {
    let topic, professor: String
    let captions: [Caption]

    enum CodingKeys: String, CodingKey {
        case topic, professor, captions
    }
}
