//
//  Geo.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import Foundation

struct Geo: Codable {
    let lat: String
    let lng: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decode(String.self, forKey: .lat)
        self.lng = try container.decode(String.self, forKey: .lng)
    }
}
