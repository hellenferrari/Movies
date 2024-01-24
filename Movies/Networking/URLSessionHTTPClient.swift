//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import Foundation

enum HandlerError: Error {
    case invalidError
}

struct URLSessionHTTPClient: HTTPClient {
    let session: URLSession
    
    func get(url: URL) async throws -> Result<Data, Error> {
        do {
            let (data, response) = try await session.data(from: url)
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200, !data.isEmpty {
                    return .success(data)
                } else {
                    return .failure(HandlerError.invalidError)
                }
            }
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}


//func getMovies() async -> Result<Data, Error> {
//    do {
//        let url = URL(string: "https://www.omdbapi.com/?s=Tita&apikey=672578c6")!
//        let session = URLSession.shared
//        let (data, response) = try await session.data(from: url)
//
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromPascalCase
//
//        let movies = try decoder.decode(MoviesResult.self, from: data)
//        print("Data: ", movies)
//        print("Response: ", response)
//
//        if let response = response as? HTTPURLResponse {
//            if response.statusCode == 200, !data.isEmpty {
//                return .success(data)
//            } else {
//                return .failure(ErrorHandler.invalidData)
//            }
//        }
//        return .success(data)
//
//    } catch {
//        print(error)
//        return .failure(error)
//    }
//}


