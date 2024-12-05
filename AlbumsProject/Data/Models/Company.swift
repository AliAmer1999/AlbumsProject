//
//  Company.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import Foundation

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.catchPhrase = try container.decode(String.self, forKey: .catchPhrase)
        self.bs = try container.decode(String.self, forKey: .bs)
    }
    
}
