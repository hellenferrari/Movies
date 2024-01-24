//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import Foundation

class MovieService: MoviesLoader {
    let httpClient: HTTPClient
    let baseUrl: String
    
    init(httpClient: HTTPClient, baseUrl: String) {
        self.httpClient = httpClient
        self.baseUrl = baseUrl
    }
    
    func getMovies(_ content: String) async throws -> [Movie] {
        let type = "?s="
        let content = content
        let apiKey = "&apikey=672578c6"
        let url = URL(string: baseUrl + type + content + apiKey)!
        
        let result = try await httpClient.get(url: url)
        
        switch result {
        case .failure(let error): throw error
            
        case .success(let data):
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromPascalCase
            let moviesResult = try decoder.decode(MoviesResult.self, from: data)

            let movies = moviesResult.search
            return movies
        }
    }
}
