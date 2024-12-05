//
//  GetAlbumsUseCase.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import Foundation


protocol GetAlbumsUseCase {
    
    func getAlbums(userId: Int, completion: @escaping (Result<[Album],AlbumProjectError>) -> Void)
}
