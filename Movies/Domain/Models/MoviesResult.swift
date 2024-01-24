//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import Foundation

struct MoviesResult: Codable {
    let search: [Movie]
    let totalResults: String
    let response: String
}

