//
//  GetPhotosRepositoryImplementation.swift
//  AlbumsProject
//
//  Created by Ali Amer on 05/12/2024.
//

import Foundation


class GetPhotosRepositoryImplementation: GetPhotosRepository {
    
    
    func getPhotos(albumId: Int, completion: @escaping (Result<[Photo], AlbumProjectError>) -> ()) {
        let apiPath = "/photos"
        let baseURL = Constants.baseURL + apiPath
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "albumId", value: String(albumId)),
        ]
        guard let url = urlComponents?.url else {
            let albumError = AlbumProjectError(message:"Invalid URL")
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
                    let photos = try JSONDecoder().decode([Photo].self, from: data)
                    completion(.success(photos))
                } catch {
                    let err = AlbumProjectError(message: "Error Decoding Photos")
                    completion(.failure(err))
                }
            }
        }

      
        task.resume()
      
    }
}
