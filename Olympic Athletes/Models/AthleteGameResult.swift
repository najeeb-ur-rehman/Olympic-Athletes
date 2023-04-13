//
//  AthleteGameResult.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 11/04/2023.
//

import Foundation

struct AthleteGameResult: Codable {
    let city: String?
    let year: Int?
    let gold: Int?
    let silver: Int?
    let bronze: Int?
}
