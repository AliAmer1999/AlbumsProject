//
//  GetUsersRepositoryImplementation.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import Foundation

class GetUsersRepositoryImplementation: GetUsersRepository {
    
    func getUsers(completion: @escaping (Result<[User], AlbumProjectError>) -> ()) {
        let apiPath = "/users"
        let baseURL = Constants.baseURL + apiPath
        let urlComponents = URLComponents(string: baseURL)
        guard let url = urlComponents?.url else {
            let albumError = AlbumProjectError(message: "Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                let albumError = AlbumProjectError(message: error.localizedDescription)
                completion(.failure(albumError))
                return
            }
            if let data = data {
                do {
                    let users: [User] = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(users))
                } catch {
                    let err = AlbumProjectError(message: "Error Decoding Users")
                    completion(.failure(err))
                }
            }
        }
        task.resume()
    }
 
}
