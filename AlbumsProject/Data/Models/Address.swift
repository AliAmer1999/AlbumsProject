//
//  Address.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import Foundation

struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    
    enum CodingKeys: CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decode(String.self, forKey: .street)
        self.suite = try container.decode(String.self, forKey: .suite)
        self.city = try container.decode(String.self, forKey: .city)
        self.zipcode = try container.decode(String.self, forKey: .zipcode)
        self.geo = try container.decode(Geo.self, forKey: .geo)
    }
}
