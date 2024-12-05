//
//  AlbumDetailsViewModel.swift
//  AlbumsProject
//
//  Created by Ali Amer on 04/12/2024.
//

import Foundation


class AlbumDetailsViewModel {
    
    let getPhotosUseCase: GetPhotosUseCase
    @Published var photos: [Photo]?
    @Published var error: AlbumProjectError?
    
    init(getPhotosUseCase: GetPhotosUseCase = GetPhotosUseCaseImplementation()) {
        self.getPhotosUseCase = getPhotosUseCase
    }
    
    func getPhotos(albumID: Int) {
        getPhotosUseCase.getPhotos(albumID: albumID) { [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos = photos
            case .failure(let failure):
                self?.error = failure
            }
        }
    }
}
