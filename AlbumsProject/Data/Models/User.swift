//
//  User.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.username = try container.decode(String.self, forKey: .username)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(Address.self, forKey: .address)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.website = try container.decode(String.self, forKey: .website)
        self.company = try container.decode(Company.self, forKey: .company)
    }
}
