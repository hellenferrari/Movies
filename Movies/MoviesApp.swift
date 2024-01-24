//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import SwiftUI

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            let session = URLSession.shared
            let httpClient = URLSessionHTTPClient(session: session)
            let url = "https://www.omdbapi.com/"
            let movieService = MovieService(httpClient: httpClient, baseUrl: url)
            let viewModel = MoviesViewModel(service: movieService)
            MoviesListView(viewModel: viewModel)
        }
    }
}
