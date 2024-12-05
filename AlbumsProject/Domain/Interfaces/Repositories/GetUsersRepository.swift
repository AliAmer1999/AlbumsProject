//
//  GetUsersRepository.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import Foundation

protocol GetUsersRepository {
    func getUsers(completion:@escaping(Result<[User],AlbumProjectError>) ->())
}
