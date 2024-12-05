//
//  ProfileViewModel.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import Foundation
import Combine
class ProfileViewModel {
    private let getUsersUseCase: GetUsersUseCase
    private let getAlbumsUseCase: GetAlbumsUseCase
    @Published var users: [User]?
    @Published var albums: [Album]?
    @Published var error: AlbumProjectError?
    
    init(getUsersUseCase: GetUsersUseCase = GetUsersUseCaseImplementation(), getAlbumsUseCase: GetAlbumsUseCase = GetAlbumsUseCaseImplementation()) {
        self.getUsersUseCase = getUsersUseCase
        self.getAlbumsUseCase = getAlbumsUseCase
    }
    
    func getUsers() {
        getUsersUseCase.getUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let failure):
                let albumProjectError = AlbumProjectError(message: failure.localizedDescription)
                self?.error = albumProjectError
            }
        }
    }
    
    func getAlbums(userId: Int) {
        getAlbumsUseCase.getAlbums(userId: userId) { [weak self] result in
            switch result {
            case .success(let albums):
                self?.albums = albums
            case .failure(let failure):
                self?.error = failure
            }
        }
    }
}
