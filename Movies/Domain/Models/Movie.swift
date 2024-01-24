//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import Foundation

public struct Movie: Codable, Hashable {
    public let title: String
    public let year: String
    public let imdbID: String
    public let type: String
    public let poster: URL
    
    public init(title: String, year: String, imdbID: String, type: String, poster: URL) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.poster = poster
    }
}
