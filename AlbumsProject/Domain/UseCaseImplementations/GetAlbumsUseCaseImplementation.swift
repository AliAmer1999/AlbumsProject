//
//  GetAlbumsUseCaseImplementation.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import Foundation


class GetAlbumsUseCaseImplementation: GetAlbumsUseCase {
    private var getAlbumsRepository: GetAlbumsRepository
    
    init(getAlbumsRepository: GetAlbumsRepository = GetAlbumsRepositoryImplementation()) {
        self.getAlbumsRepository = getAlbumsRepository
    }
    func getAlbums(userId: Int, completion: @escaping (Result<[Album], AlbumProjectError>) -> Void) {
        getAlbumsRepository.getAlbums(userId: userId) { result in
            switch result {
            case .success(let albums):
                completion(.success(albums))
            case .failure(let failure):
                let albumError = AlbumProjectError(message: failure.localizedDescription)
                completion(.failure(failure as! AlbumProjectError))
            }
        }
    }
}
