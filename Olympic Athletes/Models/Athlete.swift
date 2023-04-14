//
//  Athlete.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 10/04/2023.
//

import Foundation

struct Athlete: Codable {
    
    let athleteId: String
    let name: String?
    let surname: String?
    let dateOfBirth: String?
    let bio: String?
    let weight: Int?
    let height: Int?
    let photoId: Int?

    enum CodingKeys: String, CodingKey {
        case athleteId = "athlete_id"
        case photoId = "photo_id"
        case name, surname, dateOfBirth, bio, weight, height
    }

}
