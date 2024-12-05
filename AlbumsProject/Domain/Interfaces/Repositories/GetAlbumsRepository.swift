//
//  GetAlbumsRepository.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import Foundation

protocol GetAlbumsRepository {
    func getAlbums(userId: Int, completion: @escaping (Result<[Album],AlbumProjectError>) -> Void)
}
