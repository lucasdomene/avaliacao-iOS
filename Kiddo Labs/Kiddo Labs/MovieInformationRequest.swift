//
//  MovieInformationRequest.swift
//  Kiddo Labs
//
//  Created by Lucas Domene Firmo on 8/22/16.
//  Copyright © 2016 Domene. All rights reserved.
//

import Foundation

class MovieInformationRequest: BaseRequest {
    
    // MARK: - Attributes
    private var path = MOVIE_DETAILS_PATH
    
    // MARK: - Instance Methods
    func makeRequest(movie: Movie, completion: (Movie?, ErrorType?) -> ()) {
        super.makeRequest(.GET, path: path + String(movie.id), parameters: nil) { response in
            guard let json = response.result.value as? JSONDictionary else {
                if response.result.error?.code == -1009 {
                    completion(nil, InternetError.NoConnection)
                } else {
                    completion(nil, JSONMappingError.KeyNotFound)
                }
                return
            }
            
            let data = movie.movieInformation(json)
            return completion(data.0, data.1)
        }
    }
}