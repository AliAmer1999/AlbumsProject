//
//  GetPhotosRepository.swift
//  AlbumsProject
//
//  Created by Ali Amer on 05/12/2024.
//

import Foundation


protocol GetPhotosRepository {
    func getPhotos(albumId: Int, completion: @escaping (Result<[Photo],AlbumProjectError>) -> ())
}
