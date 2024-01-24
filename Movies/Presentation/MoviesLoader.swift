//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import Foundation

protocol MoviesLoader {
    func getMovies(_ content: String) async throws -> [Movie]
}
