//
//  GetAlbumsRepositoryImplementation.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import Foundation


class GetAlbumsRepositoryImplementation: GetAlbumsRepository {
    
    func getAlbums(userId: Int, completion: @escaping (Result<[Album], AlbumProjectError>) -> Void) {
        let apiPath = "/albums"
        let baseURL = Constants.baseURL + apiPath
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "userId", value: String(userId)),
        ]
        guard let url = urlComponents?.url else {
            let albumError = AlbumProjectError(message: "Invalid URL")
            completion(.failure(albumError))
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
                    let albums = try JSONDecoder().decode([Album].self, from: data)
                    completion(.success(albums))
                } catch {
                    let err = AlbumProjectError(message: "Error Decoding Albums")
                    completion(.failure(err))
                }
            }
        }
        task.resume()
    }
}
