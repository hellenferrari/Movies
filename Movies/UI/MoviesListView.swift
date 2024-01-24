//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: MoviesViewModel
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(viewModel.movies, id: \.self) { movie in
                    Text(movie.title)
                }
            }
        }
        .onAppear {
            Task { @MainActor in
                await loadMovies()
            }
        }
    }
    
    func loadMovies() async {
        await viewModel.fetchMovies(content: "Tita")
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        let session = URLSession.shared
        let httpClient = URLSessionHTTPClient(session: session)
        let url = "https://www.omdbapi.com/?s=Tita&apikey=672578c6"
        let moviesService = MoviesService(httpClient: httpClient, baseUrl: url)
        MoviesListView(viewModel: MoviesViewModel(service: moviesService))
    }
}

