//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesViewModelTests: XCTestCase {

    var viewModel: MoviesViewModel!
    var mockService: MockMovieService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let session = URLSession.shared
        let httpClient = URLSessionHTTPClient(session: session)
        let url = "https://www.omdbapi.com/"
        mockService = MockMovieService(httpClient: httpClient, baseUrl: url)
        viewModel = MoviesViewModel(service: mockService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
        try super.tearDownWithError()
    }

    func test_fetchMovies_success() async {
        let expectedMovies = [Movie(title: "Titanic", year: "1997", imdbID: "tt0120338", type: "movie", poster: URL(string: "https://m.media-amazon.com/images/1MzY@._V1_SX300.jpg")!)]
        mockService.movies = expectedMovies

        await viewModel.fetchMovies(with: "Titanic")

        XCTAssertEqual(viewModel.loadingState, .loaded)
        XCTAssertEqual(viewModel.movies, expectedMovies)
    }

    func test_FetchMovies_failure() async {
        let expectedError = NSError(domain: "TestErrorDomain", code: 42, userInfo: nil)
        mockService.error = expectedError

        await viewModel.fetchMovies(with: "Test Content")

        XCTAssertEqual(viewModel.loadingState, .failed)
        XCTAssertTrue(viewModel.movies.isEmpty)
    }
    
    // MARK: -- Helpers
    
    class MockMovieService: MovieService {
        var movies: [Movie] = []
        var error: Error?
        
        override func getMovies(_ content: String) async throws -> [Movie] {
            if let error = error {
                throw error
            } else {
                return movies
            }
        }
    }

}

