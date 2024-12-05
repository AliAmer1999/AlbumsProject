//
//  GetPhotosUseCase.swift
//  AlbumsProject
//
//  Created by Ali Amer on 05/12/2024.
//

import Foundation


protocol GetPhotosUseCase {
    
    func getPhotos(albumID: Int, completion: @escaping (Result<[Photo],AlbumProjectError>) -> ())
}
