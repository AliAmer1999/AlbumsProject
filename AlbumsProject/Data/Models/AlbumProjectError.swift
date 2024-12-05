//
//  Error.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import Foundation

class AlbumProjectError: Error {
    let message: String
    
    init(message: String) {
        self.message = message
    }
}
