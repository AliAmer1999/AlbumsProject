//
//  GetPhotosUseCaseImplementation.swift
//  AlbumsProject
//
//  Created by Ali Amer on 05/12/2024.
//

import Foundation


class GetPhotosUseCaseImplementation: GetPhotosUseCase {
    
    let getPhotosRepository: GetPhotosRepository
    
    init(getPhotosRepository: GetPhotosRepository = GetPhotosRepositoryImplementation()) {
        self.getPhotosRepository = getPhotosRepository
    }
    func getPhotos(albumID: Int, completion: @escaping (Result<[Photo], AlbumProjectError>) -> ()) {
        getPhotosRepository.getPhotos(albumId: albumID) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
