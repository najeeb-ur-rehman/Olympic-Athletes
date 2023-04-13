//
//  UIImageView+Extensions.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 12/04/2023.
//

import SDWebImage

extension UIImageView {
    
    func setAthletePhotoWithId(_ id: Int?) {
        let placeholder = UIImage(named: "profile_placeholder")
        guard let photoId = id else {
            self.image = placeholder
            return
        }
        let baseUrl = Environment.current.baseUrl
        let athletePhotoUrl = URL(string: "athletes/\(photoId)/photo", relativeTo: baseUrl)
        self.sd_setImage(with: athletePhotoUrl, placeholderImage: placeholder)
    }
}
