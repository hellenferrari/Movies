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
