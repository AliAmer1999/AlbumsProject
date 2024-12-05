//
//  Album.swift
//  AlbumsProject
//
//  Created by Ali Amer on 04/12/2024.
//

import Foundation
struct Album: Codable {
    let userId: Int
    let id: Int
    let title: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
    }
}
