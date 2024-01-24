//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {
    let service: MoviesService
    @Published var searchText = ""
    @Published var movies = [Movie]()
    @Published var loadingState = LoadingState.loading
    private var cancellables: Set<AnyCancellable> = []
    
    init(service: MoviesService) {
        self.service = service
        
        $searchText
            .removeDuplicates()
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                Task {
                    await self.fetchMovies(with: text)
                }
            }
            .store(in: &cancellables)
    }
    
    enum LoadingState {
        case loading, loaded, empty, failed
    }
    
    @MainActor
    func fetchMovies(with content: String) async {
        do {
            let originalString = content
            let stringWithPercent = originalString.replacingOccurrences(of: " ", with: "%20")
            movies = try await service.getMovies(stringWithPercent)
        } catch {
            loadingState = .failed
        }
    }
    
}

