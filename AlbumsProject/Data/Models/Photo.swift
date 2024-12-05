//
//  Photo.swift
//  AlbumsProject
//
//  Created by Ali Amer on 05/12/2024.
//

import Foundation

struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.albumId = try container.decode(Int.self, forKey: .albumId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
        self.thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
    }
}
