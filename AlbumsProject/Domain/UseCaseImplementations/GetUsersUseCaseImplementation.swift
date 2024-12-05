//
//  GetUsersUseCaseImplementation.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import Foundation

class GetUsersUseCaseImplementation: GetUsersUseCase {
   
    private let getUsersRepository: GetUsersRepository
    
    init(getUserRepository: GetUsersRepository = GetUsersRepositoryImplementation()) {
        self.getUsersRepository = getUserRepository
    }
    
    func getUsers(completion: @escaping (Result<[User],AlbumProjectError>) -> ()) {
        getUsersRepository.getUsers { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}
