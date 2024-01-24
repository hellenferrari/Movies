//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import Foundation

struct MoviesService: MoviesLoader {
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
        let fullUrl = URL(string: baseUrl + type + content + apiKey)!
        let result = try await httpClient.get(url: fullUrl)
        
        switch result {
        case .failure(let error): throw error
            
        case .success(let data):
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromPascalCase
            let moviesResult = try decoder.decode(MoviesResult.self, from: data)

            let movies = moviesResult.search
            print("Movies from Service: ", moviesResult.totalResults)
            return movies
        }
    }
    
}


extension JSONDecoder.KeyDecodingStrategy {
    static var convertFromPascalCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { keys -> CodingKey in
            let key = keys.last!
            guard key.intValue == nil else {
                return key
            }
            
            let codingKeyType = type(of: key)
            let newStringValue = key.stringValue.firstCharLowercased()
            
            return codingKeyType.init(stringValue: newStringValue)!
        }
    }
}

private extension String {
    func firstCharLowercased() -> String {
        prefix(1).lowercased() + dropFirst()
    }
}
