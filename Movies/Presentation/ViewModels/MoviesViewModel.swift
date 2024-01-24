//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import Foundation

class MoviesViewModel: ObservableObject {
    let service: MoviesService
    
    init(service: MoviesService) {
        self.service = service
    }
    
    @Published var movies = [Movie]()
    @Published var loadingState = LoadingState.loading
    
    enum LoadingState {
        case loading, loaded, empty, failed
    }
    
    @MainActor
    func fetchMovies(content: String) async {
        do {
            movies = try await service.getMovies(content)
        } catch {
            loadingState = .failed
        }
    }
    
}

